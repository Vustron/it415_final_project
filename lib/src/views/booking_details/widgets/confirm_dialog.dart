import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants/styles.dart';

Widget confirmationDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    title: const Row(
      children: <Widget>[
        Icon(
          FluentIcons.question_circle_24_regular,
          color: GlobalStyles.primaryButtonColor,
        ),
        SizedBox(width: 8),
        Text('Confirm Booking'),
      ],
    ),
    content: const Text(
      'Are you sure you want to confirm this booking?',
      style: TextStyle(fontSize: 16),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[800])),
      ),
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(true),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalStyles.primaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Confirm'),
      ),
    ],
  );
}
