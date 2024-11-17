import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'inputfield.freezed.dart';

@freezed
class InputFieldConfig with _$InputFieldConfig {
  const factory InputFieldConfig({
    required String label,
    required String type,
    required String hintText,
    String? value,
    @Default(false) bool isRequired,
    int? minLength,
    int? maxLength,
    List<String>? options,
    TextInputType? keyboardType,
    @Default(false) bool obscureText,
    IconData? prefixIcon,
    List<String>? allowedFileTypes,
  }) = _InputFieldConfig;
}
