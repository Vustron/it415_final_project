import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:babysitterapp/src/views.dart';

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

  final User? user = FirebaseAuth.instance.currentUser;

  if (context.mounted) {
    Navigator.pushReplacement<void, void>(
      context,
      PageTransition<void>(
        type: PageTransitionType.size,
        alignment: Alignment.bottomCenter,
        child: user != null ? const BottomNavbarView() : LoginView(),
      ),
    );
  }
}
