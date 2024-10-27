// third party
import 'package:page_transition/page_transition.dart';

// flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// views
import 'package:babysitterapp/views/login/view.dart';

Future<void> transitionHome(BuildContext context) async {
  await Future<void>.delayed(
    const Duration(milliseconds: 3000),
  );

  if (!context.mounted) {
    return;
  }

  // Exit full-screen
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    systemNavigationBarColor: Colors.black,
  ));

  // Navigate to the new screen
  if (context.mounted) {
    Navigator.pushReplacement<void, void>(
      context,
      PageTransition<void>(
        type: PageTransitionType.size,
        alignment: Alignment.bottomCenter,
        child: const LoginView(),
      ),
    );
  }
}
