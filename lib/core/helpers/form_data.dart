import 'package:flutter/material.dart';

import 'package:babysitterapp/models/inputfield.dart';

class FormData extends ChangeNotifier {
  FormData(List<InputFieldConfig> fields) {
    _data = Map<String, String>.fromEntries(
      fields.map((InputFieldConfig field) =>
          MapEntry<String, String>(field.label, field.value ?? '')),
    );
    _errors = Map<String, String?>.fromEntries(
      fields.map((InputFieldConfig field) =>
          MapEntry<String, String?>(field.label, null)),
    );
  }

  late Map<String, String> _data;
  // ignore: unused_field
  late Map<String, String?> _errors;

  void updateField(String label, String value) {
    _data[label] = value;
    notifyListeners();
  }

  String? getValue(String label) => _data[label];
  Map<String, String> get data => _data;
}
