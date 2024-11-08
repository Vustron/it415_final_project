import 'package:flutter/material.dart';

void showTermsAndConditions(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Here are the terms and conditions...\n\n'
              '1. You agree to the terms and conditions.\n'
              '2. You will not misuse the application.\n'
              '3. Your data will be handled with care.\n'
              '4. You agree to follow the rules and regulations.\n'
              '5. The terms and conditions are subject to change.\n\n'
              'Please read the terms and conditions carefully before using the application.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
