import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/inputfield.dart';

Widget buildField(
  InputFieldConfig field,
  Map<String, TextEditingController> controllers,
  ValueNotifier<Map<String, String>> formData,
  ValueNotifier<Map<String, String?>> errors,
  ValueNotifier<bool> isLoading,
  Map<String, ValueNotifier<FilePickerState>> fileStates,
) {
  switch (field.type) {
    case 'select':
      return buildSelectField(
        field,
        formData,
        errors,
        isLoading,
      );
    case 'file':
      return buildFileField(
        field,
        formData,
        fileStates,
        isLoading,
      );
    case 'text':
    case 'password':
    case 'email':
    default:
      return buildTextField(
        field,
        controllers,
        formData,
        errors,
        isLoading,
      );
  }
}
