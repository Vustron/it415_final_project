// flutter
import 'package:flutter/material.dart';

ThemeData rootThemeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
    ),
    useMaterial3: true,
    fontFamily: 'Nexa-ExtraLight',
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    dialogBackgroundColor: Colors.white,
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
        foregroundColor: const Color(0xFF1686AA),
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFF1686AA),
        ),
      ),
    ),
  );
}
