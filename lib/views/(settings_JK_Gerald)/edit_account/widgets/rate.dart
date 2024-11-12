import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

class EditRate extends StatelessWidget {
  const EditRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Rate',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: GlobalStyles.primaryButtonColor),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: '₱300',
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your rate here',
          ),
        )
      ],
    );
  }
}
