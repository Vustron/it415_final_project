import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

Widget sectionTitle(String title, IconData icon) {
  return Row(
    children: <Widget>[
      Icon(icon, color: GlobalStyles.primaryButtonColor, size: 24),
      const SizedBox(width: 8),
      Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: GlobalStyles.filterColorScheme.onBackground),
      ),
    ],
  );
}
