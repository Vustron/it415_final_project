import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/services/auth_repository.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/models.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._dataSource) : super(const AuthState.initial()) {
    getCurrentUser();
  }

  final AuthRepository _dataSource;
  bool _hasInitialized = false;

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    final Either<String, UserAccount?> response =
        await _dataSource.login(email: email, password: password);
    state = response.fold(
      (String error) => AuthState.unauthenticated(message: error),
      (UserAccount? user) => user != null
          ? AuthState.authenticated(user: user)
          : const AuthState.unauthenticated(message: 'User not found'),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    state = const AuthState.loading();
    final Either<String, UserAccount> response = await _dataSource.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );
    state = response.fold(
      (String error) => AuthState.unauthenticated(message: error),
      (UserAccount user) => AuthState.authenticated(user: user),
    );
  }

  Future<void> continueWithGoogle() async {
    state = const AuthState.loading();
    final Either<String, UserAccount> response =
        await _dataSource.continueWithGoogle();
    state = response.fold(
      (String error) => AuthState.unauthenticated(message: error),
      (UserAccount user) => AuthState.authenticated(user: user),
    );
  }

  Future<void> logout() async {
    await _dataSource.logout();
    state = const AuthState.unauthenticated();
    _hasInitialized = false;
  }

  Future<Either<String, UserAccount>> getUser() async {
    return _dataSource.getUser();
  }

  Future<void> getCurrentUser() async {
    if (_hasInitialized) {
      return;
    }

    print('Getting current user...');
    state = const AuthState.loading();
    final Either<String, UserAccount> response = await _dataSource.getUser();
    response.fold(
      (String error) {
        print('Error getting user: $error');
        state = AuthState.unauthenticated(message: error);
      },
      (UserAccount user) {
        print('Got user: ${user.name}');
        state = AuthState.authenticated(user: user);
      },
    );
    _hasInitialized = true;
  }

  Future<void> deleteAccount() async {
    state = const AuthState.loading();
    final Either<String, void> response = await _dataSource.deleteAccount();
    state = response.fold(
      (String error) => AuthState.unauthenticated(message: error),
      (_) => const AuthState.unauthenticated(),
    );
  }

  Future<void> updateAccount(UserAccount updatedUser) async {
    state = const AuthState.loading();
    final Either<String, UserAccount> response =
        await _dataSource.updateAccount(updatedUser);
    state = response.fold(
      (String error) => AuthState.unauthenticated(message: error),
      (UserAccount user) => AuthState.authenticated(user: user),
    );
  }

  Future<String?> uploadFile(String path, String? filePath) async {
    return _dataSource.uploadFile(path, filePath);
  }
}

final StateNotifierProvider<AuthController, AuthState> authController =
    StateNotifierProvider<AuthController, AuthState>(
  (StateNotifierProviderRef<AuthController, AuthState> ref) => AuthController(
    ref.read(authRepository),
  ),
);
