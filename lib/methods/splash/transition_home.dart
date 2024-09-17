// utils
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// screens
import 'package:babysitterapp/screens/navbar.dart';

Future<void> transitionHome(BuildContext context) async {
  // Delay for 3 seconds
  await Future<void>.delayed(
    const Duration(milliseconds: 3000),
  );

  // Check if the widget is still mounted before proceeding
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
        child: const NavbarScreen(),
      ),
    );
  }
}
