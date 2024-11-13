import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/booking.dart';

Widget buildDetailsSection(
    BuildContext context, String details, void Function(String) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      buildSectionTitle(context, 'Additional Details', Icons.note_add),
      const SizedBox(height: 8),
      Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Any special requirements or notes?',
              border: InputBorder.none,
            ),
            maxLines: 3,
            onChanged: onChanged,
            style: const TextStyle(
              fontFamily: nexaExtraLight,
            ),
          ),
        ),
      ),
    ],
  );
}
