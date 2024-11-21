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

  Future<Either<AuthFailure, UserAccount>> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final UserAccount userData =
            await getUserData(userCredential.user!.uid);
        return right(userData);
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

  Future<UserAccount> getUserData(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await fireStore.collection('users').doc(uid).get();
    return UserAccount.fromJson(doc.data() ?? <String, dynamic>{});
  }

  Future<void> saveUserData(UserAccount user) async {
    await fireStore.collection('users').doc(user.id).set(user.toJson());
  }
}
