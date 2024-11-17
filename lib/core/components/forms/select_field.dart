import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/models/models.dart';

Widget buildSelectField(
  InputFieldConfig field,
  ValueNotifier<Map<String, String>> formData,
  ValueNotifier<Map<String, String?>> errors,
  ValueNotifier<bool> isLoading,
) {
  return CustomSelect<String>(
    items: field.options ?? <String>[],
    value: formData.value[field.label]!.isEmpty
        ? null
        : formData.value[field.label],
    hint: field.hintText,
    onChanged: (String? value) {
      if (value != null) {
        formData.value = <String, String>{
          ...formData.value,
          field.label: value
        };
      }
    },
    isRequired: field.isRequired,
    errorText: errors.value[field.label],
    enabled: !isLoading.value,
    validator: getValidator(field),
  );
}
