// utils
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

PageTransitionType _getPageTransitionType(String transitionType) {
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

void goToPage(BuildContext context, Widget page, String transitionType,
    [Alignment? alignment]) {
  final PageTransitionType type = _getPageTransitionType(transitionType);
  Navigator.of(context).push(
    PageTransition<dynamic>(
      type: type,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      child: page,
      alignment: alignment,
    ),
  );
}
