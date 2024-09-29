// utils
import 'package:flutter/material.dart';

mixin GlobalStyles {
  /*-------------- Text Styles --------------*/
  final TextStyle headerStyle = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
  final TextStyle labelStyle = const TextStyle(
    fontSize: 18,
  );
  static const Color kPrimaryColor = Color.fromARGB(255, 233, 107, 216);
  static const Color kPrimaryLightColor = Color.fromARGB(255, 177, 209, 245);
  static const double defaultPadding = 16.0;
}
