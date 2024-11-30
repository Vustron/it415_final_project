import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.authRepo, this.logger) : super(AuthState());

  final AuthRepository authRepo;
  final LoggerService logger;
  StreamSubscription<Either<AuthFailure, UserAccount>>? userSubscription;

  void initUserStream(String uid) {
    logger.debug('Initializing user stream for uid: $uid');
    userSubscription?.cancel();
    userSubscription = authRepo.getUserDataStream(uid).listen(
      (Either<AuthFailure, UserAccount> result) {
        result.fold(
          (AuthFailure failure) {
            logger.error('User stream error', failure.message);
            state = state.copyWith(
              isLoading: false,
              error: failure.message,
              status: AuthStatus.error,
              hasShownToast: false,
            );
          },
          (UserAccount user) {
            logger.info('User stream updated: ${user.id}');
            state = state.copyWith(
              isLoading: false,
              user: user,
              status: AuthStatus.authenticated,
              hasShownToast: false,
            );
          },
        );
      },
      onError: (dynamic error, StackTrace stackTrace) {
        logger.error('User stream error', error, stackTrace);
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
    if (state.isLoading) {
      logger.debug('Login skipped - already loading');
      return;
    }

    logger.info('Attempting login for email: $email');
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.login(email: email, password: password);

      result.fold(
        (AuthFailure failure) {
          logger.error('Login failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (UserAccount user) async {
          logger.info('Login successful for user: ${user.id}');
          final UserAccount updatedUser = user.copyWith(onlineStatus: true);
          await authRepo.updateUser(updatedUser);

          initUserStream(user.id!);
          state = state.copyWith(
            isLoading: false,
            user: updatedUser,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Login error', e, stackTrace);
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
      logger.debug('Registration skipped - already loading');
      return;
    }

    logger.info('Attempting registration for email: $email');
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
        (AuthFailure failure) {
          logger.error('Registration failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (UserAccount user) {
          logger.info('Registration successful for user: ${user.id}');
          initUserStream(user.id!);
          state = state.copyWith(
            isLoading: false,
            user: user,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Registration error', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Future<void> logout() async {
    logger.info('Attempting logout');
    try {
      if (state.user != null) {
        final UserAccount updatedUser =
            state.user!.copyWith(onlineStatus: false);
        await authRepo.updateUser(updatedUser);
        logger.debug('Updated user online status to offline');
      }

      await userSubscription?.cancel();
      await FirebaseAuth.instance.signOut();
      logger.info('Logout successful');
      state = AuthState(status: AuthStatus.unauthenticated);
      CustomRouter.pushNamedAndRemoveUntil(Routes.login);
    } catch (e, stackTrace) {
      logger.error('Logout error', e, stackTrace);
      state = state.copyWith(
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
      rethrow;
    }
  }

  Future<void> getUserData(String uid) async {
    logger.debug('Fetching user data for uid: $uid');
    try {
      state = state.copyWith(
        isLoading: true,
        status: AuthStatus.initial,
        hasShownToast: false,
      );

      initUserStream(uid);
    } catch (e, stackTrace) {
      logger.error('Error fetching user data', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Future<void> updateUser(UserAccount user) async {
    if (state.isLoading) {
      logger.debug('Update skipped - already loading');
      return;
    }

    logger.info('Updating user: ${user.id}');
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.authenticated,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.updateUser(user);

      result.fold(
        (AuthFailure failure) {
          logger.error('Update failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (UserAccount updatedUser) {
          logger.info('User updated successfully: ${updatedUser.id}');
          initUserStream(updatedUser.id!);
          state = state.copyWith(
            isLoading: false,
            user: updatedUser,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Update error', e, stackTrace);
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
    if (state.isLoading) {
      logger.debug('Delete image skipped - already loading');
      return;
    }

    logger.info('Deleting profile image for user: $userId');
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
        (AuthFailure failure) {
          logger.error('Delete image failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (_) {
          logger.info('Profile image deleted successfully');
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
    } catch (e, stackTrace) {
      logger.error('Delete image error', e, stackTrace);
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
    logger.debug('Disposing AuthController');
    userSubscription?.cancel();
    super.dispose();
  }

  Future<void> loginUsingGoogle() async {
    if (state.isLoading) {
      logger.debug('Google login skipped - already loading');
      return;
    }

    logger.info('Attempting Google login');
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, UserAccount> result =
          await authRepo.loginWithGoogle();

      result.fold(
        (AuthFailure failure) {
          logger.error('Google login failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (UserAccount user) async {
          logger.info('Google login successful for user: ${user.id}');
          final UserAccount updatedUser = user.copyWith(onlineStatus: true);
          await authRepo.updateUser(updatedUser);
          initUserStream(user.id!);
          state = state.copyWith(
            isLoading: false,
            user: user,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Google login error', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Future<void> sendEmailVerification() async {
    if (state.isLoading) {
      logger.debug('Email verification skipped - already loading');
      return;
    }

    logger.info('Sending email verification');
    state = state.copyWith(
      isLoading: true,
      status: AuthStatus.initial,
      hasShownToast: false,
    );

    try {
      final Either<AuthFailure, Unit> result =
          await authRepo.sendEmailVerification();

      result.fold(
        (AuthFailure failure) {
          logger.error('Email verification failed', failure.message);
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            status: AuthStatus.error,
            hasShownToast: false,
          );
        },
        (_) {
          logger.info('Email verification sent successfully');
          state = state.copyWith(
            isLoading: false,
            status: AuthStatus.authenticated,
            hasShownToast: false,
          );
        },
      );
    } catch (e, stackTrace) {
      logger.error('Email verification error', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        status: AuthStatus.error,
        hasShownToast: false,
      );
    }
  }

  Stream<List<UserAccount>> getBabysittersStream() {
    logger.debug('Starting babysitters stream');

    return authRepo
        .getUsersStream(role: 'Babysitter')
        .map((List<UserAccount> users) {
      logger.info('Received ${users.length} babysitters from stream');
      return users;
    }).handleError((dynamic error, StackTrace stackTrace) {
      logger.error(
          'Stream error in getUsersStream', error, stackTrace as StackTrace?);
      throw Exception('Stream error in getUsersStream: $error');
    });
  }

  Stream<Either<AuthFailure, UserAccount>> getUserDataStream(String uid) {
    logger.debug('Getting user data stream for: $uid');
    return authRepo
        .getUserDataStream(uid)
        .handleError((dynamic error, StackTrace stack) {
      logger.error('Error in user data stream', error, stack);
      throw Exception('Stream error in getUserDataStream: $error');
    });
  }
}
