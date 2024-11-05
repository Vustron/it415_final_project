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
  final TextStyle hintTextStyle = const TextStyle(
    color: Colors.grey, // Default hint color
  );

  
  /*-------------- Color Styles --------------*/
  
  /// Primary button color
  ///  /// Primary button color
  static const Color primaryButtonColor = Color(0xFF1686AA);

  /// App bar background color
  static const Color appBarBackgroundColor = Colors.white;

  /// Text color for the app bar
  static const Color appBarTextColor = Colors.black;

  /// Card color
  static const Color cardColor = Colors.white;

  /// Dialog background color
  static const Color dialogBackgroundColor = Colors.white;

  /// Secondary button color
  static const Color secondaryButtonColor = Colors.white;

  /// Main brand colors
  static const Color kPrimaryColor = Color.fromARGB(255, 233, 107, 216);
  static const Color kPrimaryLightColor = Color.fromARGB(255, 177, 209, 245);

  /// Default fill color for text fields
  static const Color defaultFillColor = Color(0xFFF0F0F0); // Light grey

  /// Default border color for text fields
  static const Color defaultBorderColor = Color(0xFFD0D0D0); // Light grey for borders

  /// Default focused border color for text fields
  static const Color defaultFocusedBorderColor = Color(0xFF1686AA); // Primary button color

  /// Color scheme for filters or special cases
  static const ColorScheme filterColorScheme = ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.lightBlueAccent,
  );

  /// App bar background color

  /// Text color for icons or elements in the app bar
  static const Color appBarIconColor = Colors.black;

  /*-------------- Padding Styles --------------*/
  
  /// Standard padding for consistent spacing
  static const double defaultPadding = 16.0;

  /// Additional smaller padding
  static const double smallPadding = 8.0;

  /// Padding for larger sections
  static const double largePadding = 24.0;

    /// Default padding for text fields
  static const EdgeInsetsGeometry defaultContentPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 16);

  /*-------------- Size Styles --------------*/

  /// Default size for components (e.g., TextInput height, button height)
  static const double defaultSize = 50.0;

  /// Width and height for standard square icons
  static const double defaultIconSize = 24.0; // Ensure this line is present
}
