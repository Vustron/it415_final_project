// core
import 'package:babysitterapp/core/providers/firebase_providers.dart';
import 'package:babysitterapp/core/config/firebase_options.dart';

// third party
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

final Provider<AuthenticationRepository> authenticationRepository =
    Provider<AuthenticationRepository>(
  (ProviderRef<AuthenticationRepository> ref) =>
      AuthenticationRepository(ref.read(firebaseAuthProvider), ref),
);

class AuthenticationRepository {
  AuthenticationRepository(this._firebaseAuth, this._ref);

  final FirebaseAuth _firebaseAuth;
  // ignore: unused_field
  final Ref _ref; // use for reading other providers

  Future<Either<String, User>> register(
      {required String email, required String password}) async {
    try {
      final UserCredential response = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup.');
    }
  }

  Future<Either<String, User?>> login(
      {required String email, required String password}) async {
    try {
      final UserCredential response =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(response.user);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Login');
    }
  }

  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
          clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential response =
            await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      } else {
        return left('Unknown Error');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown Error');
    }
  }
}
