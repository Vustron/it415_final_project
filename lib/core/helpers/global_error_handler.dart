import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/views/error.dart';
import 'package:babysitterapp/views/root.dart';

void globalErrorHandler(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  final NavigatorState? navigator = navigatorKey.currentState;
  if (navigator != null) {
    navigator.pushAndRemoveUntil(
      PageTransition<void>(
        type: PageTransitionType.rightToLeftWithFade,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: ErrorView(error: details.exceptionAsString()),
      ),
      (_) => false,
    );
  }
}
