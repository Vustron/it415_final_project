import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class AuthFailure {
  AuthFailure(this.message);
  final String message;
}

class AuthRepository {
  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : auth = firebaseAuth,
        fireStore = firestore,
        firebaseStorage = storage;

  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;

  Future<Either<AuthFailure, UserAccount>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Either<AuthFailure, String> emailValidation = validateEmail(email);
      if (emailValidation.isLeft()) {
        return emailValidation.fold(
          (AuthFailure failure) => left(failure),
          (_) => left(
            AuthFailure(''),
          ),
        );
      }

      final Either<AuthFailure, String> passwordValidation =
          validatePassword(password);
      if (passwordValidation.isLeft()) {
        return passwordValidation.fold(
          (AuthFailure failure) => left<AuthFailure, UserAccount>(failure),
          (_) => left(
            AuthFailure(''),
          ),
        );
      }

      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final Stream<Either<AuthFailure, UserAccount>> userDataStream =
            getUserDataStream(userCredential.user!.uid);
        final Either<AuthFailure, UserAccount> userDataResult =
            await userDataStream.first;
        return userDataResult;
      }
      return left(AuthFailure('Login failed'));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? 'Authentication failed'));
    }
  }

  Future<Either<AuthFailure, UserAccount>> register({
    required String email,
    required String password,
    required String name,
    required String role,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      final Either<AuthFailure, String> emailValidation = validateEmail(email);
      if (emailValidation.isLeft()) {
        return left(
          emailValidation.fold(
            (AuthFailure l) => l,
            (String r) => AuthFailure(''),
          ),
        );
      }

      final Either<AuthFailure, String> passwordValidation =
          validatePassword(password);
      if (passwordValidation.isLeft()) {
        return left(
          passwordValidation.fold(
            (AuthFailure l) => l,
            (String r) => AuthFailure(''),
          ),
        );
      }

      final Either<AuthFailure, String> nameValidation = validateName(name);
      if (nameValidation.isLeft()) {
        return left(
          nameValidation.fold(
            (AuthFailure l) => l,
            (String r) => AuthFailure(''),
          ),
        );
      }

      if (role.isEmpty) {
        return left(AuthFailure('Role cannot be empty'));
      }

      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final UserAccount user = UserAccount(
          id: userCredential.user!.uid,
          name: name,
          address: address,
          phoneNumber: phoneNumber,
          email: email,
          provider: 'emailwithpassword',
          profileImg: '',
          description: '',
          validId: '',
          gender: '',
          role: role,
          onlineStatus: true,
          emailVerified: null,
          validIdVerified: null,
          validIdFront: '',
          validIdBack: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await saveUserData(user);
        return right(user);
      }
      return left(AuthFailure('Registration failed'));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? 'Registration failed'));
    }
  }

  Stream<Either<AuthFailure, UserAccount>> getUserDataStream(String uid) {
    if (uid.isEmpty) {
      return Stream<Either<AuthFailure, UserAccount>>.value(
          left(AuthFailure('User ID cannot be empty')));
    }

    return fireStore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map<Either<AuthFailure, UserAccount>>(
      (DocumentSnapshot<Map<String, dynamic>> snapshot) {
        try {
          if (!snapshot.exists) {
            return left(AuthFailure('User not found'));
          }

          final Map<String, dynamic>? data = snapshot.data();
          if (data == null) {
            return left(AuthFailure('User data is corrupted'));
          }

          return right(UserAccount.fromJson(data));
        } catch (e) {
          return left(AuthFailure('Unexpected error: $e'));
        }
      },
    ).handleError((dynamic error) {
      if (error is FirebaseException) {
        return left<AuthFailure, UserAccount>(
            AuthFailure('Firebase error: ${error.message}'));
      }
      return left<AuthFailure, UserAccount>(
          AuthFailure('Unexpected error: $error'));
    });
  }

  Future<Either<AuthFailure, Unit>> saveUserData(UserAccount user) async {
    try {
      if (user.id!.isEmpty) {
        return left(AuthFailure('User ID cannot be empty'));
      }
      await fireStore.collection('users').doc(user.id).set(user.toJson());
      return right(unit);
    } catch (e) {
      return left(AuthFailure('Failed to save user data: $e'));
    }
  }

  Future<Either<AuthFailure, String>> uploadImages(
      String uid, File image) async {
    try {
      final String path = 'images/$uid';
      final Reference folderRef = firebaseStorage.ref().child(path);

      try {
        final ListResult result = await folderRef.listAll();
        for (final Reference ref in result.items) {
          await ref.delete();
        }
      } catch (e) {
        print('No images found in the folder: $e');
      }

      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference ref = firebaseStorage.ref().child('$path/$fileName');

      final SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: <String, String>{'userId': uid},
      );

      final UploadTask uploadTask = ref.putFile(image, metadata);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print('Data transferred: ${snapshot.bytesTransferred / 1000} kb');
      });
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return right(downloadUrl);
    } catch (e) {
      return left(AuthFailure('Failed to upload image: $e'));
    }
  }

  Future<Either<AuthFailure, UserAccount>> updateUser(UserAccount user) async {
    try {
      if (user.id == null || user.id!.isEmpty) {
        return left(AuthFailure('User ID cannot be empty'));
      }

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection('users').doc(user.id).get();

      if (!doc.exists) {
        return left(AuthFailure('User not found'));
      }

      final Map<String, dynamic> currentData =
          doc.data() ?? <String, dynamic>{};
      final Map<String, dynamic> updateData = user.toJson();

      if (updateData['profileImg'] == null ||
          (updateData['profileImg'] is String &&
              (updateData['profileImg'] as String).isEmpty)) {
        updateData['profileImg'] = currentData['profileImg'] ?? '';
      }

      await fireStore.collection('users').doc(user.id).update(updateData);

      final DocumentSnapshot<Map<String, dynamic>> updatedDoc =
          await fireStore.collection('users').doc(user.id).get();

      return right(UserAccount.fromJson(updatedDoc.data()!));
    } catch (e) {
      return left(AuthFailure('Failed to update user: $e'));
    }
  }

  Future<Either<AuthFailure, Unit>> deleteProfileImage(
      String uid, String imageUrl, String imageType) async {
    try {
      final Map<String, dynamic> updateData = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (imageUrl.isEmpty) {
        if (imageType == 'Profile Image') {
          updateData['profileImg'] = '';
        }

        await fireStore.collection('users').doc(uid).update(updateData);
        return right(unit);
      }

      final Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();

      if (imageType == 'Profile Image') {
        updateData['profileImg'] = '';
      }

      await fireStore.collection('users').doc(uid).update(updateData);

      return right(unit);
    } catch (e) {
      return left(AuthFailure('Failed to delete image: $e'));
    }
  }

  Future<Either<AuthFailure, UserAccount>> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return left(AuthFailure('Google sign in was cancelled'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        return left(AuthFailure('Failed to sign in with Google'));
      }

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection('users').doc(firebaseUser.uid).get();

      if (doc.exists) {
        return right(UserAccount.fromJson(doc.data()!));
      } else {
        final UserAccount newUser = UserAccount(
          id: firebaseUser.uid,
          name: firebaseUser.displayName,
          address: '',
          phoneNumber: '',
          email: firebaseUser.email,
          provider: 'google',
          profileImg: firebaseUser.photoURL,
          description: '',
          validId: '',
          gender: '',
          role: '',
          onlineStatus: true,
          emailVerified: DateTime.now(),
          validIdVerified: null,
          validIdFront: '',
          validIdBack: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await saveUserData(newUser);
        return right(newUser);
      }
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e.message ?? 'Firebase authentication failed'));
    }
  }

  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    try {
      final User? user = auth.currentUser;
      if (user == null) {
        return left(AuthFailure('No user logged in'));
      }

      await user.sendEmailVerification();

      user.reload();
      if (user.emailVerified) {
        await fireStore.collection('users').doc(user.uid).update({
          'emailVerified': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        });
      }

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(
          AuthFailure(e.message ?? 'Failed to send verification email'));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
