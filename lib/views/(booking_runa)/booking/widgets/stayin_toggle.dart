// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget buildStayInToggle(bool stayIn, void Function(bool) onChanged) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.home, color: GlobalStyles.primaryButtonColor),
              SizedBox(width: 8),
              Text('Stay In', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Switch(
            value: stayIn,
            onChanged: onChanged,
            activeColor: GlobalStyles.primaryButtonColor,
          ),
        ],
      ),
    ),
  );
}
