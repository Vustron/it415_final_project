// utils

import 'package:babysitterapp/utils/styles.dart';

import 'package:flutter/material.dart';

// widgets
import 'section_title.dart';
import 'checkbox.dart';
import 'card.dart';

Widget additionsSection() {
  return filterCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            sectionTitle('Additions', Icons.add_circle_outline),
            TextButton(
              child: Text(
                'See all',
                style: TextStyle(color: GlobalStyles.filterColorScheme.primary),
              ),
              onPressed: () {},
            ),
          ],
        ),
        ...<Widget>[const AdditionCheckbox()],
      ],
    ),
  );
}
