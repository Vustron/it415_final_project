import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget with GlobalStyles {
  SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: labelStyle,
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            //Code Here
          },
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Nexa-ExtraLight',
              color: GlobalStyles.primaryButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
