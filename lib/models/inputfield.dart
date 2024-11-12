import 'package:flutter/material.dart';

class InputFieldConfig {
  InputFieldConfig({
    required this.label,
    required this.type,
    required this.hintText,
    this.value,
    this.isRequired = false,
    this.minLength,
    this.maxLength,
    this.options,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.allowedFileTypes,
  });

  final String label;
  final String type;
  final String hintText;
  final String? value;
  final bool isRequired;
  final int? minLength;
  final int? maxLength;
  final List<String>? options;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final List<String>? allowedFileTypes;
}
