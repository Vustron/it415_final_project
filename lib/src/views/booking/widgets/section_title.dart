import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

Widget buildSectionTitle(BuildContext context, String title, IconData icon) {
  return Row(
    children: <Widget>[
      Icon(icon, color: GlobalStyles.primaryButtonColor),
      const SizedBox(width: 8),
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: GlobalStyles.primaryButtonColor,
              fontFamily: nexaExtraLight,
            ),
      ),
    ],
  );
}
