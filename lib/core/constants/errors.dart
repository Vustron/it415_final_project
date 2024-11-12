import 'package:firebase_auth/firebase_auth.dart';

class AuthError {
  static const String emailAlreadyInUse =
      'The email address is already in use by another account.';
  static const String userNotFound = 'No user found for that email.';
  static const String wrongPassword = 'Wrong password provided for that user.';
  static const String weakPassword = 'The password provided is too weak.';
  static const String invalidEmail = 'The email address is not valid.';
  static const String unknownError =
      'An unknown error occurred. Please try again later.';
  static const String genericError =
      'Failed to perform the operation. Please try again.';
  static const String createUserWithEmailAndPasswordError =
      'Failed to create user with email and password. Please try again.';
}

String handleFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return AuthError.emailAlreadyInUse;
    case 'user-not-found':
      return AuthError.userNotFound;
    case 'wrong-password':
      return AuthError.wrongPassword;
    case 'weak-password':
      return AuthError.weakPassword;
    case 'invalid-email':
      return AuthError.invalidEmail;
    case 'dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.createUserWithEmailAndPassword':
      return AuthError.createUserWithEmailAndPasswordError;
    default:
      return e.message ?? AuthError.unknownError;
  }
}
