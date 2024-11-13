import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/views/error.dart';
import 'package:babysitterapp/views/auth.dart';
import 'package:babysitterapp/views/home.dart';

class AuthGuard extends ConsumerStatefulWidget {
  const AuthGuard({super.key});

  @override
  AuthGuardState createState() => AuthGuardState();
}

class AuthGuardState extends ConsumerState<AuthGuard> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _handleAuthState();
    });
  }

  void _handleAuthState() {
    ref.listen<AuthenticationState>(
      authController,
      (AuthenticationState? previous, AuthenticationState next) {
        next.whenOrNull(
          authenticated: (_) {
            if (mounted) {
              goToPage(
                  context, const BottomNavbarView(), 'rightToLeftWithFade');
            }
          },
          unauthenticated: (String? message) {
            if (mounted) {
              goToPage(context, const LoginView(), 'rightToLeftWithFade');
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationState authState = ref.watch(authController);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: GlobalStyles.primaryButtonColor,
          ),
        ),
      ),
      authenticated: (_) => HomeView(),
      unauthenticated: (String? message) => const LoginView(),
      error: (String error, StackTrace? stackTrace) => ErrorView(
        error: error,
      ),
      initial: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: GlobalStyles.primaryButtonColor,
          ),
        ),
      ),
    );
  }
}
