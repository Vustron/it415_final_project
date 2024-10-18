// utils
import 'package:flutter/material.dart';

// configs
import 'root_appbar.dart';

ThemeData rootThemeData() {
  return ThemeData(
    appBarTheme: rootAppBarTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
    useMaterial3: true,
    fontFamily: 'Nexa-ExtraLight',
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1686AA),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1686AA),
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1686AA), // Button text color
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
    ),
  );
}
