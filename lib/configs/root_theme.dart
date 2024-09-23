// utils
import 'package:flutter/material.dart';

// configs
import 'root_appbar.dart';

ThemeData rootThemeData() {
  return ThemeData(
    appBarTheme: rootAppBarTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
    useMaterial3: true, 
    fontFamily: 'Quicksan_Book',
  );
}
