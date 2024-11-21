import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class YearsExperience extends StatelessWidget {
  const YearsExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        SizedBox(width: 18),
        Icon(
          Icons.baby_changing_station,
          color: GlobalStyles.primaryButtonColor,
          size: 35,
        ),
        SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'BabySitting Experience',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '+8 years',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
