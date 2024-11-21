import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:babysitterapp/src/controllers/auth_controller.dart';

import 'package:babysitterapp/src/providers.dart';

import 'package:babysitterapp/src/services/auth_repository.dart';

import 'package:babysitterapp/src/models.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((ProviderRef<AuthRepository> ref) {
  final FirebaseAuth auth = ref.watch(firebaseAuthProvider);
  final FirebaseFirestore firestore = ref.watch(firebaseFirestoreProvider);
  return AuthRepository(
    firebaseAuth: auth,
    firestore: firestore,
  );
});

final StateNotifierProvider<AuthController, AuthState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>(
        (StateNotifierProviderRef<AuthController, AuthState> ref) {
  final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository);
});
