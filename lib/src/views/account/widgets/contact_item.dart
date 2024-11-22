import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class ContactItem extends StatelessWidget with GlobalStyles {
  ContactItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: GlobalStyles.primaryButtonColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
