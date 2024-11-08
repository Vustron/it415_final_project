import 'package:flutter/material.dart';

class InputFieldConfig {
  InputFieldConfig({
    required this.label,
    required this.type,
    this.value,
    this.keyboardType,
    this.obscureText = false,
    this.hintText = 'Enter text...',
    this.prefixIcon,
    this.cursorColor,
    this.textInputAction,
    this.options,
  });

  final String label;
  final String type;
  final String? value;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String hintText;
  final IconData? prefixIcon;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final List<String>? options;
}
