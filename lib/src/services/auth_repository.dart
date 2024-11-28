import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:babysitterapp/src/services.dart';
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
    required LoggerService logger,
  })  : auth = firebaseAuth,
        fireStore = firestore,
        firebaseStorage = storage,
        _logger = logger;

  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;
  final LoggerService _logger;

  Future<Either<AuthFailure, UserAccount>> login({
    required String email,
    required String password,
  }) async {
    _logger.info('Attempting login for email: $email');
    try {
      final Either<AuthFailure, String> emailValidation = validateEmail(email);
      if (emailValidation.isLeft()) {
        _logger.warning('Invalid email format');
        return emailValidation.fold(
          (AuthFailure failure) => left(failure),
          (_) => left(AuthFailure('')),
        );
      }

      final Either<AuthFailure, String> passwordValidation =
          validatePassword(password);
      if (passwordValidation.isLeft()) {
        _logger.warning('Invalid password format');
        return passwordValidation.fold(
          (AuthFailure failure) => left(failure),
          (_) => left(AuthFailure('')),
        );
      }

      _logger.debug('Attempting Firebase login');
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _logger.debug('Firebase login successful, fetching user data');
        final Stream<Either<AuthFailure, UserAccount>> userDataStream =
            getUserDataStream(userCredential.user!.uid);
        final Either<AuthFailure, UserAccount> userDataResult =
            await userDataStream.first;
        return userDataResult;
      }
      _logger.error('Login failed - no user returned');
      return left(AuthFailure('Login failed'));
    } on FirebaseAuthException catch (e, stack) {
      _logger.error('Firebase auth error', e, stack);
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
    _logger.info('Attempting registration for email: $email');
    try {
      final Either<AuthFailure, String> emailValidation = validateEmail(email);
      if (emailValidation.isLeft()) {
        _logger.warning('Invalid email format during registration');
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
        _logger.warning('Invalid password format during registration');
        return left(
          passwordValidation.fold(
            (AuthFailure l) => l,
            (String r) => AuthFailure(''),
          ),
        );
      }

      final Either<AuthFailure, String> nameValidation = validateName(name);
      if (nameValidation.isLeft()) {
        _logger.warning('Invalid name format during registration');
        return left(
          nameValidation.fold(
            (AuthFailure l) => l,
            (String r) => AuthFailure(''),
          ),
        );
      }

      if (role.isEmpty) {
        _logger.warning('Empty role provided during registration');
        return left(AuthFailure('Role cannot be empty'));
      }

      _logger.debug('Creating Firebase user account');
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _logger.debug('Firebase account created, saving user data');
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
        _logger.info('User registration completed successfully');
        return right(user);
      }
      _logger.error('Registration failed - no user returned');
      return left(AuthFailure('Registration failed'));
    } on FirebaseAuthException catch (e, stack) {
      _logger.error('Firebase registration error', e, stack);
      return left(AuthFailure(e.message ?? 'Registration failed'));
    }
  }

  Stream<Either<AuthFailure, UserAccount>> getUserDataStream(String uid) {
    _logger.debug('Starting user data stream for uid: $uid');
    if (uid.isEmpty) {
      _logger.warning('Empty user ID provided for data stream');
      return Stream<Either<AuthFailure, UserAccount>>.value(
        left(
          AuthFailure('User ID cannot be empty'),
        ),
      );
    }

    return fireStore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map<Either<AuthFailure, UserAccount>>(
            (DocumentSnapshot<Map<String, dynamic>> snapshot) {
      try {
        if (!snapshot.exists) {
          _logger.warning('User document not found: $uid');
          return left(AuthFailure('User not found'));
        }

        final Map<String, dynamic>? data = snapshot.data();
        if (data == null) {
          _logger.error('Corrupted user data for uid: $uid');
          return left(AuthFailure('User data is corrupted'));
        }

        _logger.debug('User data retrieved successfully');
        return right(UserAccount.fromJson(data));
      } catch (e, stack) {
        _logger.error('Error processing user data', e, stack);
        return left(AuthFailure('Unexpected error: $e'));
      }
    }).handleError((dynamic error, dynamic stack) {
      _logger.error('Stream error', error, stack as StackTrace?);
      if (error is FirebaseException) {
        return left<AuthFailure, UserAccount>(
          AuthFailure('Firebase error: ${error.message}'),
        );
      }
      return left<AuthFailure, UserAccount>(
        AuthFailure('Unexpected error: $error'),
      );
    });
  }

  Future<Either<AuthFailure, Unit>> saveUserData(UserAccount user) async {
    _logger.info('Saving user data for id: ${user.id}');
    try {
      if (user.id!.isEmpty) {
        _logger.warning('Empty user ID provided for save operation');
        return left(AuthFailure('User ID cannot be empty'));
      }
      await fireStore.collection('users').doc(user.id).set(user.toJson());
      _logger.debug('User data saved successfully');
      return right(unit);
    } catch (e, stack) {
      _logger.error('Failed to save user data', e, stack);
      return left(AuthFailure('Failed to save user data: $e'));
    }
  }

  Future<Either<AuthFailure, String>> uploadImages(
      String uid, File image) async {
    _logger.info('Uploading image for user: $uid');
    try {
      final String path = 'images/$uid';
      final Reference folderRef = firebaseStorage.ref().child(path);

      try {
        _logger.debug('Cleaning up existing images');
        final ListResult result = await folderRef.listAll();
        for (final Reference ref in result.items) {
          await ref.delete();
        }
      } catch (e) {
        _logger.debug('No existing images found: $e');
      }

      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference ref = firebaseStorage.ref().child('$path/$fileName');

      final SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: <String, String>{'userId': uid},
      );

      _logger.debug('Starting image upload');
      final UploadTask uploadTask = ref.putFile(image, metadata);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        _logger
            .debug('Upload progress: ${snapshot.bytesTransferred / 1000} kb');
      });

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _logger.info('Image upload completed successfully');
      return right(downloadUrl);
    } catch (e, stack) {
      _logger.error('Failed to upload image', e, stack);
      return left(AuthFailure('Failed to upload image: $e'));
    }
  }

  Future<Either<AuthFailure, UserAccount>> updateUser(UserAccount user) async {
    _logger.info('Updating user: ${user.id}');
    try {
      if (user.id == null || user.id!.isEmpty) {
        _logger.warning('Empty user ID provided for update');
        return left(AuthFailure('User ID cannot be empty'));
      }

      final DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection('users').doc(user.id).get();

      if (!doc.exists) {
        _logger.warning('User not found for update: ${user.id}');
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

      _logger.debug('Updating user document');
      await fireStore.collection('users').doc(user.id).update(updateData);

      final DocumentSnapshot<Map<String, dynamic>> updatedDoc =
          await fireStore.collection('users').doc(user.id).get();
      _logger.info('User updated successfully');
      return right(UserAccount.fromJson(updatedDoc.data()!));
    } catch (e, stack) {
      _logger.error('Failed to update user', e, stack);
      return left(AuthFailure('Failed to update user: $e'));
    }
  }

  Future<Either<AuthFailure, Unit>> deleteProfileImage(
    String uid,
    String imageUrl,
    String imageType,
  ) async {
    _logger.info('Deleting profile image for user: $uid');
    try {
      final Map<String, dynamic> updateData = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (imageUrl.isEmpty) {
        if (imageType == 'Profile Image') {
          updateData['profileImg'] = '';
        }

        await fireStore.collection('users').doc(uid).update(updateData);
        _logger.debug('Image reference removed from user document');
        return right(unit);
      }

      _logger.debug('Deleting image from storage');
      final Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();

      if (imageType == 'Profile Image') {
        updateData['profileImg'] = '';
      }

      await fireStore.collection('users').doc(uid).update(updateData);
      _logger.info('Profile image deleted successfully');
      return right(unit);
    } catch (e, stack) {
      _logger.error('Failed to delete image', e, stack);
      return left(AuthFailure('Failed to delete image: $e'));
    }
  }

  Future<Either<AuthFailure, UserAccount>> loginWithGoogle() async {
    _logger.info('Attempting Google login');
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        _logger.warning('Google sign in was cancelled by user');
        return left(AuthFailure('Google sign in was cancelled'));
      }

      _logger.debug('Getting Google auth credentials');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _logger.debug('Signing in to Firebase with Google credential');
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        _logger.error('Failed to get Firebase user from Google credential');
        return left(AuthFailure('Failed to sign in with Google'));
      }

      _logger.debug('Checking if user exists in Firestore');
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection('users').doc(firebaseUser.uid).get();

      if (doc.exists) {
        _logger.info('Existing Google user signed in');
        return right(UserAccount.fromJson(doc.data()!));
      } else {
        _logger.debug('Creating new user from Google account');
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
        _logger.info('New Google user created successfully');
        return right(newUser);
      }
    } on FirebaseAuthException catch (e, stack) {
      _logger.error('Firebase auth error during Google login', e, stack);
      return left(AuthFailure(e.message ?? 'Firebase authentication failed'));
    }
  }

  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    _logger.info('Sending email verification');
    try {
      final User? user = auth.currentUser;
      if (user == null) {
        _logger.warning('No user logged in for email verification');
        return left(AuthFailure('No user logged in'));
      }

      _logger.debug('Sending verification email');
      await user.sendEmailVerification();

      user.reload();
      _logger.debug('Updating email verification status');
      await fireStore
          .collection('users')
          .doc(user.uid)
          .update(<Object, Object?>{
        'emailVerified': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      _logger.info('Email verification sent successfully');
      return right(unit);
    } on FirebaseAuthException catch (e, stack) {
      _logger.error('Failed to send verification email', e, stack);
      return left(
          AuthFailure(e.message ?? 'Failed to send verification email'));
    } catch (e, stack) {
      _logger.error('Unexpected error during email verification', e, stack);
      return left(AuthFailure(e.toString()));
    }
  }
}
