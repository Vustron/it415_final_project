import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.authRepo) : super(AuthState());

  final AuthRepository authRepo;

  void markToastAsShown() {
    state = state.copyWith(hasShownToast: true);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      error: null,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result = await authRepo.login(
        email: email,
        password: password,
      );

      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
          hasShownToast: false,
        ),
        (UserAccount user) => state = state.copyWith(
          isLoading: false,
          user: user,
          status: AuthStatus.authenticated,
          hasShownToast: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String role,
    String? phoneNumber,
    String? address,
  }) async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      // ignore: avoid_redundant_argument_values
      error: null,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result = await authRepo.register(
        email: email,
        password: password,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
        address: address,
      );

      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
          hasShownToast: false,
        ),
        (UserAccount user) => state = state.copyWith(
          isLoading: false,
          user: user,
          status: AuthStatus.authenticated,
          hasShownToast: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    state = AuthState(status: AuthStatus.unauthenticated);
    CustomRouter.pushNamedAndRemoveUntil(Routes.login);
  }

  Future<void> getUserData(String uid) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      status: AuthStatus.initial,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.getUserData(uid);
      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
        ),
        (UserAccount user) => state = state.copyWith(
          user: user,
          isLoading: false,
          status: AuthStatus.authenticated,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
      );
    }
  }

  Future<void> updateUser(UserAccount user) async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
      isLoading: true,
      error: null,
      status: AuthStatus.initial,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.updateUser(user);

      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
          hasShownToast: false,
        ),
        (UserAccount updatedUser) => state = state.copyWith(
          isLoading: false,
          user: updatedUser,
          status: AuthStatus.authenticated,
          hasShownToast: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }
}
