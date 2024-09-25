// utils
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

void gotoPage(BuildContext context, Widget page) {
  Navigator.of(context).push(
    PageTransition<dynamic>(
      type: PageTransitionType.rightToLeftWithFade,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      child: page,
    ),
  );
}
