import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/models.dart';

class AuthFailure {
  AuthFailure(this.message);
  final String message;
}

class AuthRepository {
  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : auth = firebaseAuth,
        fireStore = firestore;
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  // Validation methods
  Either<AuthFailure, String> validateEmail(String email) {
    if (email.isEmpty) {
      return left(AuthFailure('Email cannot be empty'));
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return left(
        AuthFailure('Invalid email format'),
      );
    }
    return right(email);
  }

  Either<AuthFailure, String> validatePassword(String password) {
    if (password.isEmpty) {
      return left(AuthFailure('Password cannot be empty'));
    }
    if (password.length < 6) {
      return left(AuthFailure('Password must be at least 8 characters'));
    }
    return right(password);
  }

  Either<AuthFailure, String> validateName(String name) {
    if (name.isEmpty) {
      return left(AuthFailure('Name cannot be empty'));
    }
    if (name.length < 2) {
      return left(AuthFailure('Name must be at least 2 characters'));
    }
    return right(name);
  }

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

  Future<Either<AuthFailure, UserAccount>> updateUser(UserAccount user) async {
    if (user.id == null || user.id!.isEmpty) {
      return left(AuthFailure('User ID cannot be empty'));
    }

    try {
      if (user.name != null) {
        final Either<AuthFailure, String> nameValidation =
            validateName(user.name!);
        if (nameValidation.isLeft()) {
          return left(nameValidation.fold(
              (AuthFailure l) => l, (String r) => AuthFailure('')));
        }
      }

      final UserAccount updatedUser = UserAccount(
        id: user.id,
        name: user.name,
        email: user.email,
        phoneNumber: user.phoneNumber,
        address: user.address,
        provider: user.provider,
        profileImg: user.profileImg,
        description: user.description,
        validId: user.validId,
        role: user.role,
        onlineStatus: user.onlineStatus,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );

      await fireStore
          .collection('users')
          .doc(user.id)
          .update(updatedUser.toJson());

      return right(updatedUser);
    } catch (e) {
      return left(AuthFailure('Failed to update user: $e'));
    }
  }
}
