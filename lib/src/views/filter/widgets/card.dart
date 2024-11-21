import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

Widget filterCard({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFD0D0D0),
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    padding: GlobalStyles.defaultContentPadding,
    child: child,
  );
}
