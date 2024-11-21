import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static PageTransitionType _getPageTransitionType(String transitionType) {
    switch (transitionType) {
      case 'theme':
        return PageTransitionType.theme;
      case 'fade':
        return PageTransitionType.fade;
      case 'rightToLeft':
        return PageTransitionType.rightToLeft;
      case 'leftToRight':
        return PageTransitionType.leftToRight;
      case 'topToBottom':
        return PageTransitionType.topToBottom;
      case 'bottomToTop':
        return PageTransitionType.bottomToTop;
      case 'scale':
        return PageTransitionType.scale;
      case 'rotate':
        return PageTransitionType.rotate;
      case 'size':
        return PageTransitionType.size;
      case 'rightToLeftWithFade':
        return PageTransitionType.rightToLeftWithFade;
      case 'leftToRightWithFade':
        return PageTransitionType.leftToRightWithFade;
      case 'leftToRightJoined':
        return PageTransitionType.leftToRightJoined;
      case 'rightToLeftJoined':
        return PageTransitionType.rightToLeftJoined;
      case 'topToBottomJoined':
        return PageTransitionType.topToBottomJoined;
      case 'bottomToTopJoined':
        return PageTransitionType.bottomToTopJoined;
      case 'leftToRightPop':
        return PageTransitionType.leftToRightPop;
      case 'rightToLeftPop':
        return PageTransitionType.rightToLeftPop;
      case 'topToBottomPop':
        return PageTransitionType.topToBottomPop;
      case 'bottomToTopPop':
        return PageTransitionType.bottomToTopPop;
      default:
        throw ArgumentError('Invalid PageTransitionType: $transitionType');
    }
  }

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToWithTransition(
    Widget page,
    String transitionType, {
    Alignment? alignment,
    bool replace = false,
  }) {
    final PageTransitionType type = _getPageTransitionType(transitionType);
    final PageTransition<dynamic> route = PageTransition<dynamic>(
      type: type,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      child: page,
      alignment: alignment,
    );

    return replace
        ? navigatorKey.currentState!.pushReplacement(route)
        : navigatorKey.currentState!.push(route);
  }

  static void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void pushNamedAndRemoveUntil(String routeName) {
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
}
