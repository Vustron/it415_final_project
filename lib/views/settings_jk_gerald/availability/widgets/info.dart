import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

class Info extends StatelessWidget with GlobalStyles {
  Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'February 15, 2024',
            style: labelStyle,
          ),
        ),
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            '8:00 AM - 6:00 PM',
            style: optionTextStyle,
          ),
        ),
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        const Divider(),
        const SizedBox(
          height: GlobalStyles.defaultPadding,
        ),
      ],
    );
  }
}
