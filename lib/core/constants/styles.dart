// flutter
import 'package:flutter/material.dart';

mixin GlobalStyles {
  /*-------------- Text Styles --------------*/

  /// Large header style for primary titles
  final TextStyle headerStyle = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    fontFamily: 'Nexa-Heavy',
  );

  /// Style for general labels and captions
  final TextStyle labelStyle = const TextStyle(
    fontSize: 18,
    fontFamily: 'Nexa-ExtraLight',
  );

  /// Style for options or button labels
  final TextStyle optionTextStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  /// Style for app bar titles or smaller headers
  static const TextStyle appBarTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );

  /// Style for hint text in text inputs
  static const TextStyle hintTextStyle = TextStyle(
    color: Colors.grey,
  );

  /*-------------- Color Styles --------------*/

  /// Primary colors
  static const Color primaryButtonColor = Color(0xFF1686AA);
  static const Color kPrimaryColor = Color.fromARGB(255, 233, 107, 216);
  static const Color kPrimaryLightColor = Color.fromARGB(255, 177, 209, 245);

  /// App bar colors
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarTextColor = Colors.black;
  static const Color appBarIconColor = Colors.black;

  /// Other element colors
  static const Color cardColor = Colors.white;
  static const Color dialogBackgroundColor = Colors.white;
  static const Color secondaryButtonColor = Colors.white;
  static const Color defaultFillColor = Color(0xFFF0F0F0);
  static const Color defaultBorderColor = Color(0xFFD0D0D0);
  static const Color defaultFocusedBorderColor = Color(0xFF1686AA);

  /// Color scheme for filters or special cases
  static const ColorScheme filterColorScheme = ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.lightBlueAccent,
  );

  /*-------------- Padding Styles --------------*/

  /// Standard padding values for consistent spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  /// Default padding for text fields
  static const EdgeInsetsGeometry defaultContentPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 16);

  /*-------------- Size Styles --------------*/

  /// Default sizes for various components
  static const double defaultSize = 50.0;
  static const double defaultIconSize = 24.0;
}

