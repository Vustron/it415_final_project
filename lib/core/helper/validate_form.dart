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
    // Get value and trim whitespace
    final String value = (formData.value[field.label] ?? '').trim();

    // Base validation for required fields
    if (field.isRequired && value.isEmpty) {
      newErrors[field.label] = '${field.label} is required';
      isValid = false;
      continue; // Skip other validations if required field is empty
    }

    // Field-specific validation
    switch (field.type) {
      case 'text':
      case 'password':
      case 'email':
        if (value.isNotEmpty) {
          if (field.minLength != null && value.length < field.minLength!) {
            newErrors[field.label] =
                '${field.label} must be at least ${field.minLength} characters';
            isValid = false;
          } else if (field.maxLength != null &&
              value.length > field.maxLength!) {
            newErrors[field.label] =
                '${field.label} must be at most ${field.maxLength} characters';
            isValid = false;
          } else if (field.type == 'email') {
            final RegExp emailRegex =
                RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
            if (!emailRegex.hasMatch(value)) {
              newErrors[field.label] = 'Please enter a valid email address';
              isValid = false;
            }
          }
        }
        break;

      case 'select':
        if (field.isRequired && value.isEmpty) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        }
        break;

      case 'file':
        if (field.isRequired && value.isEmpty) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        }
        break;
    }

    // Set null error if field is valid
    if (!newErrors.containsKey(field.label)) {
      newErrors[field.label] = null;
    }
  }

  errors.value = newErrors;
  return isValid;
}
