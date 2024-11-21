import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          (_) => left(AuthFailure('')),
        );
      }

      final Either<AuthFailure, String> passwordValidation =
          validatePassword(password);
      if (passwordValidation.isLeft()) {
        return passwordValidation.fold(
          (AuthFailure failure) => left(failure),
          (_) => left(AuthFailure('')),
        );
      }

      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final Either<AuthFailure, UserAccount> userDataResult =
            await getUserData(userCredential.user!.uid);
        return userDataResult.fold(
          (AuthFailure failure) => left(failure),
          (UserAccount userData) => right(userData),
        );
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
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          provider: 'email',
          role: role,
          onlineStatus: true,
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

  Future<Either<AuthFailure, UserAccount>> getUserData(String uid) async {
    // Validate uid
    if (uid.isEmpty) {
      return left(AuthFailure('User ID cannot be empty'));
    }

    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection('users').doc(uid).get();

      if (!doc.exists) {
        return left(AuthFailure('User not found'));
      }

      final Map<String, dynamic>? data = doc.data();
      if (data == null) {
        return left(AuthFailure('User data is corrupted'));
      }

      return right(UserAccount.fromJson(data));
    } on FirebaseException catch (e) {
      return left(AuthFailure('Firebase error: ${e.message}'));
    } catch (e) {
      return left(AuthFailure('Unexpected error: $e'));
    }
  }

  Future<Either<AuthFailure, Unit>> saveUserData(UserAccount user) async {
    if (user.id!.isEmpty) {
      return left(AuthFailure('User ID cannot be empty'));
    }

    try {
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
        // Ignore if no existing images
      }

      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference ref = firebaseStorage.ref().child('$path/$fileName');

      final SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: <String, String>{'userId': uid},
      );

      final UploadTask uploadTask = ref.putFile(image, metadata);
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

      final Map<String, dynamic> currentData = doc.data() ?? {};
      final Map<String, dynamic> updateData = user.toJson();

      if (updateData['profileImg'] == null ||
          (updateData['profileImg'] is String &&
              (updateData['profileImg'] as String).isEmpty)) {
        updateData['profileImg'] = currentData['profileImg'] ?? '';
      }
      if (updateData['validId'] == null ||
          (updateData['validId'] is String &&
              (updateData['validId'] as String).isEmpty)) {
        updateData['validId'] = currentData['validId'] ?? '';
      }

      await fireStore.collection('users').doc(user.id).update(updateData);

      final DocumentSnapshot<Map<String, dynamic>> updatedDoc =
          await fireStore.collection('users').doc(user.id).get();

      return right(UserAccount.fromJson(updatedDoc.data()!));
    } catch (e) {
      return left(AuthFailure('Failed to update user: $e'));
    }
  }

  Future<Either<AuthFailure, void>> deleteProfileImage(
      String uid, String imageUrl, String imageType) async {
    try {
      final Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();

      final Map<String, dynamic> updateData = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (imageType == 'Profile Image') {
        updateData['profileImg'] = '';
      } else if (imageType == 'Valid ID') {
        updateData['validId'] = '';
      }

      await fireStore.collection('users').doc(uid).update(updateData);

      return right(unit);
    } catch (e) {
      return left(AuthFailure('Failed to delete image: $e'));
    }
  }
}
