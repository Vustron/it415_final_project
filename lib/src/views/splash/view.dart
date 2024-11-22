import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

// splash_view.dart
class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerProvider);

    useEffect(() {
      Future<void> initializeAuth() async {
        await Future<void>.delayed(const Duration(milliseconds: 2000));
        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          ref.read(authControllerProvider.notifier).getUserData(user.uid);
        } else {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        }
      }

      initializeAuth();
      return null;
    }, const <Object?>[]);

    useEffect(() {
      if (authState.status == AuthStatus.authenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        });
      }
      return null;
    }, <Object?>[authState.status]);

    return const Scaffold(
      body: Stack(
        children: <Widget>[
          const AnimatedLogo(),
          // Positioned(
          //   bottom: MediaQuery.of(context).size.height * .28,
          //   width: MediaQuery.of(context).size.width,
          //   child: const Center(
          //     child: CircularProgressIndicator(
          //       color: GlobalStyles.primaryButtonColor,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
