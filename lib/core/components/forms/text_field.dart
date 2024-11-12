import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/models/inputfield.dart';

Widget buildTextField(
  InputFieldConfig field,
  Map<String, TextEditingController> controllers,
  ValueNotifier<Map<String, String>> formData,
  ValueNotifier<Map<String, String?>> errors,
  ValueNotifier<bool> isLoading,
) {
  return CustomTextInput(
    controller: controllers[field.label],
    hintText: field.hintText,
    keyboardType: field.keyboardType ?? TextInputType.text,
    obscureText: field.obscureText,
    prefixIcon: field.prefixIcon != null ? Icon(field.prefixIcon) : null,
    onChanged: (String value) {
      formData.value = <String, String>{...formData.value, field.label: value};
    },
    isRequired: field.isRequired,
    minLength: field.minLength,
    maxLength: field.maxLength,
    errorText: errors.value[field.label],
    enabled: !isLoading.value,
    validator: getValidator(field),
  );
}
