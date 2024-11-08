import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class EditContacts extends StatelessWidget {
  const EditContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Contacts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const SizedBox(width: 16),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Phone Number',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: GlobalStyles.primaryButtonColor),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: '09594820689',
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your phone number here',
          ),
        )
      ],
    );
  }
}
