import 'package:flutter/material.dart';

class InputFieldConfig {
  const InputFieldConfig({
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
  final dynamic value;
  final bool isRequired;
  final int? minLength;
  final int? maxLength;
  final List<String>? options;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final List<String>? allowedFileTypes;

  InputFieldConfig copyWith({
    String? label,
    String? type,
    String? hintText,
    String? value,
    bool? isRequired,
    int? minLength,
    int? maxLength,
    List<String>? options,
    TextInputType? keyboardType,
    bool? obscureText,
    IconData? prefixIcon,
    List<String>? allowedFileTypes,
  }) {
    return InputFieldConfig(
      label: label ?? this.label,
      type: type ?? this.type,
      hintText: hintText ?? this.hintText,
      value: value ?? this.value,
      isRequired: isRequired ?? this.isRequired,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      options: options ?? this.options,
      keyboardType: keyboardType ?? this.keyboardType,
      obscureText: obscureText ?? this.obscureText,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      allowedFileTypes: allowedFileTypes ?? this.allowedFileTypes,
    );
  }
}
