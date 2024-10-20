// third party
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

// core
import 'package:babysitterapp/core/state/authentication_state.dart';

// services
import 'package:babysitterapp/services/authentication_repository.dart';

final StateNotifierProvider<AuthenticationController, AuthenticationState>
    authenticationController =
    StateNotifierProvider<AuthenticationController, AuthenticationState>(
  (StateNotifierProviderRef<AuthenticationController, AuthenticationState>
          ref) =>
      AuthenticationController(ref.read(authenticationRepository)),
);

class AuthenticationController extends StateNotifier<AuthenticationState> {
  AuthenticationController(this._authenticationRepository)
      : super(const AuthenticationState.initial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> login({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final Either<String, User?> response =
        await _authenticationRepository.login(email: email, password: password);
    state = response.fold(
      (String error) => AuthenticationState.unauthenticated(message: error),
      (User? response) => AuthenticationState.authenticated(user: response!),
    );
  }

  Future<void> register(
      {required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final Either<String, User> response = await _authenticationRepository
        .register(email: email, password: password);
    state = response.fold(
      (String error) => AuthenticationState.unauthenticated(message: error),
      (User response) => AuthenticationState.authenticated(user: response),
    );
  }

  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final Either<String, User> response =
        await _authenticationRepository.continueWithGoogle();
    state = response.fold(
      (String error) => AuthenticationState.unauthenticated(message: error),
      (User response) => AuthenticationState.authenticated(user: response),
    );
  }

  Future<void> continueWithFacebook() async {
    // state = const AuthenticationState.loading();
    // final response = await _dataSource.continueWithGoogle();
    // state = response.fold(
    //   (error) => AuthenticationState.unauthenticated(message: error),
    //   (response) => AuthenticationState.authenticated(user: response),
    // );
  }
}
