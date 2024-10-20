// core
import 'package:babysitterapp/core/constants/styles.dart';
import 'section_title.dart';
import 'checkbox.dart';
import 'card.dart';

// flutter
import 'package:flutter/material.dart';

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
