import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

ThemeData filterTheme(ColorScheme filterColorScheme) {
  return ThemeData(
    colorScheme: filterColorScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalStyles.primaryButtonColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
