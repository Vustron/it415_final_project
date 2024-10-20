// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget priceDropdown({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList(),
    onChanged: onChanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: GlobalStyles.filterColorScheme.outline),
      ),
      filled: true,
      fillColor: GlobalStyles.filterColorScheme.surface,
    ),
    icon: Icon(Icons.arrow_drop_down,
        color: GlobalStyles.filterColorScheme.primary),
  );
}
