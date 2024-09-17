// utils
import 'package:flutter/material.dart';

AppBarTheme rootAppBarTheme() {
  return const AppBarTheme(
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
  );
}
