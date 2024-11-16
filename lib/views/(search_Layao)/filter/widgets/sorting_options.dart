import 'package:flutter/material.dart';

import 'package:babysitterapp/views/search.dart';

Widget sortingOptions() {
  return filterCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionTitle('Sorting by', Icons.sort),
        const SizedBox(height: 8),
        const Wrap(
          spacing: 8,
          children: <Widget>[
            ChoiceSlip(label: 'Rating', icon: Icons.star),
            ChoiceSlip(label: 'No. of Transactions', icon: Icons.work),
          ],
        ),
      ],
    ),
  );
}
