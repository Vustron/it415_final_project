// utils
import 'package:flutter/material.dart';

ThemeData filterTheme(ColorScheme filterColorScheme) {
  return ThemeData(
    colorScheme: filterColorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: filterColorScheme.surface,
      foregroundColor: filterColorScheme.onSurface,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: filterColorScheme.primary,
        foregroundColor: filterColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
