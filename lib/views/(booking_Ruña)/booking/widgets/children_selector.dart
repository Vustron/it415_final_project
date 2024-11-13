import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

Widget buildChildrenSelector(
    BuildContext context, int? numberOfChildren, void Function(int) onChanged) {
  return Card(
    elevation: 2,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            numberOfChildren == null
                ? 'Choose the number of children'
                : '$numberOfChildren ${numberOfChildren == 1 ? 'child' : 'children'}',
            style: const TextStyle(
              color: GlobalStyles.primaryButtonColor,
              fontFamily: nexaExtraLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: (numberOfChildren ?? 1).toDouble(),
            min: 1,
            max: 12,
            divisions: 12,
            label: numberOfChildren?.toString() ?? '1',
            activeColor: GlobalStyles.primaryButtonColor,
            onChanged: (double value) {
              onChanged(value.round());
            },
          ),
        ],
      ),
    ),
  );
}
