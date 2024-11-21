import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

ThemeData rootThemeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: GlobalStyles.appBarTextColor,
      ),
      titleTextStyle: GlobalStyles.appBarTitleStyle,
      backgroundColor: GlobalStyles.appBarBackgroundColor,
    ),
    useMaterial3: true,
    fontFamily: 'Nexa-ExtraLight',
    scaffoldBackgroundColor: GlobalStyles.cardColor,
    cardColor: GlobalStyles.cardColor,
    canvasColor: GlobalStyles.cardColor,
    dialogBackgroundColor: GlobalStyles.dialogBackgroundColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: GlobalStyles.primaryButtonColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalStyles.primaryButtonColor,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: GlobalStyles.primaryButtonColor,
        backgroundColor: GlobalStyles.cardColor,
        side: const BorderSide(
          color: GlobalStyles.primaryButtonColor,
        ),
      ),
    ),
  );
}
