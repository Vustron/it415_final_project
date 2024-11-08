import 'package:babysitterapp/models/inputfield.dart';
import 'package:flutter/material.dart';

bool validateForm(
  List<InputFieldConfig> fields,
  ValueNotifier<Map<String, String>> formData,
  ValueNotifier<Map<String, String?>> errors,
) {
  bool isValid = true;
  final Map<String, String?> newErrors = <String, String?>{};
  for (final InputFieldConfig field in fields) {
    final String value = formData.value[field.label] ?? '';
    switch (field.type) {
      case 'text':
      case 'password':
      case 'email':
        if (field.isRequired && value.isEmpty) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        } else if (field.minLength != null && value.length < field.minLength!) {
          newErrors[field.label] =
              '${field.label} must be at least ${field.minLength} characters';
          isValid = false;
        } else if (field.maxLength != null && value.length > field.maxLength!) {
          newErrors[field.label] =
              '${field.label} must be at most ${field.maxLength} characters';
          isValid = false;
        } else {
          newErrors[field.label] = null;
        }
      case 'select':
        if (field.isRequired && (value.isEmpty)) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        } else {
          newErrors[field.label] = null;
        }
      case 'file':
        if (field.isRequired && value.isEmpty) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        } else {
          newErrors[field.label] = null;
        }
      default:
        newErrors[field.label] = null;
        break;
    }
  }
  errors.value = newErrors;
  return isValid;
}
