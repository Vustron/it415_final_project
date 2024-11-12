import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/inputfield.dart';

Map<String, TextEditingController> useControllers(
    List<InputFieldConfig> fields) {
  return useMemoized(
    () => Map<String, TextEditingController>.fromEntries(
      fields.map(
        (InputFieldConfig field) => MapEntry<String, TextEditingController>(
          field.label,
          TextEditingController(text: field.value),
        ),
      ),
    ),
    <Object?>[fields],
  );
}

ValueNotifier<Map<String, String>> useFormData(List<InputFieldConfig> fields) {
  return useState<Map<String, String>>(
    Map<String, String>.fromEntries(
      fields.map(
        (InputFieldConfig field) =>
            MapEntry<String, String>(field.label, field.value ?? ''),
      ),
    ),
  );
}

ValueNotifier<Map<String, String?>> useErrors(List<InputFieldConfig> fields) {
  return useState<Map<String, String?>>(
    Map<String, String?>.fromEntries(
      fields.map(
        (InputFieldConfig field) =>
            MapEntry<String, String?>(field.label, null),
      ),
    ),
  );
}

Map<String, ValueNotifier<FilePickerState>> useFileStates(
    List<InputFieldConfig> fields) {
  return useMemoized(
    () => Map<String, ValueNotifier<FilePickerState>>.fromEntries(
      fields.where((InputFieldConfig field) => field.type == 'file').map(
            (InputFieldConfig field) =>
                MapEntry<String, ValueNotifier<FilePickerState>>(
              field.label,
              ValueNotifier<FilePickerState>(FilePickerState(
                filePath: field.value,
                fileName: field.value?.split('/').last,
              )),
            ),
          ),
    ),
    <Object?>[fields],
  );
}
