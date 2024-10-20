// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget sectionTitle(String title, IconData icon) {
  return Row(
    children: <Widget>[
      Icon(icon, color: GlobalStyles.filterColorScheme.primary, size: 24),
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
