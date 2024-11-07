import 'package:flutter/material.dart';

import 'section_title.dart';
import 'choice_slip.dart';
import 'card.dart';

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
            ChoiceSlip(label: 'Experience', icon: Icons.work),
          ],
        ),
      ],
    ),
  );
}
