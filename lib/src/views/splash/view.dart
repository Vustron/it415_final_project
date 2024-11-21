import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future<void> checkAuthAndRedirect() async {
        await Future<void>.delayed(const Duration(milliseconds: 3000));

        if (!context.mounted) {
          return;
        }

        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Get user data if authenticated
          await ref.read(authControllerProvider.notifier).getUserData(user.uid);

          if (!context.mounted) {
            return;
          }
          if (context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              Routes.dashboard,
            );
          }
        } else {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        }
      }

      checkAuthAndRedirect();
      return null;
    }, const <Object?>[]);

    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const AnimatedLogo(),
          Positioned(
            bottom: mq.height * .28,
            width: mq.width,
            child: const Center(
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }
}
