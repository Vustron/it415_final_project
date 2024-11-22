import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.authRepo) : super(AuthState());

  final AuthRepository authRepo;
  StreamSubscription<Either<AuthFailure, UserAccount>>? userSubscription;

  void initUserStream(String uid) {
    userSubscription?.cancel();
    userSubscription = authRepo.getUserDataStream(uid).listen(
      (Either<AuthFailure, UserAccount> result) {
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
      },
      onError: (dynamic error) {
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
          status: AuthStatus.error,
          hasShownToast: false,
        );
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.login(email: email, password: password);

      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
          hasShownToast: false,
        ),
        (UserAccount user) {
          initUserStream(user.id!);
          state = state.copyWith(
            isLoading: false,
            user: user,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
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
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
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
        (UserAccount user) {
          initUserStream(user.id!);
          state = state.copyWith(
            isLoading: false,
            user: user,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
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

  Future<void> logout() async {
    try {
      await userSubscription?.cancel();
      await FirebaseAuth.instance.signOut();
      state = AuthState(status: AuthStatus.unauthenticated);
      CustomRouter.pushNamedAndRemoveUntil(Routes.login);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
      rethrow;
    }
  }

  Future<void> getUserData(String uid) async {
    try {
      state = state.copyWith(
        isLoading: true,
        status: AuthStatus.initial,
        hasShownToast: false,
      );

      initUserStream(uid);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Future<void> updateUser(UserAccount user) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.authenticated,
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
        (UserAccount updatedUser) {
          initUserStream(updatedUser.id!);
          state = state.copyWith(
            isLoading: false,
            user: updatedUser,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
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

  Future<void> deleteProfileImage(
    String userId,
    String imageUrl,
    String imageType,
  ) async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.authenticated,
      hasShownToast: false,
    );

    try {
      final UserAccount currentUser = state.user!;
      final Either<AuthFailure, Unit> result =
          await authRepo.deleteProfileImage(userId, imageUrl, imageType);

      result.fold(
        (AuthFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
          status: AuthStatus.error,
          hasShownToast: false,
        ),
        (_) {
          final UserAccount updatedUser = imageType == 'Profile Image'
              ? currentUser.copyWith(profileImg: '')
              : currentUser;

          state = state.copyWith(
            isLoading: false,
            user: updatedUser,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
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

  @override
  void dispose() {
    userSubscription?.cancel();
    super.dispose();
  }
}
