import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers/router.dart';

import 'package:babysitterapp/src/views/error.dart';

void globalErrorHandler(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  final NavigatorState? navigator = CustomRouter.navigatorKey.currentState;
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
