import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

class ReviewsInfoPage extends StatelessWidget with GlobalStyles {
  ReviewsInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage(avatar1),
              radius: 50 / 2,
            ),
            const SizedBox(
              width: GlobalStyles.smallPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Courtney Henry',
                  style: labelStyle,
                ),
                Row(
                  children: <Widget>[
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text('5.0'),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text(
                      '•',
                    ),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text('2 mins ago'),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        Text(
          'Content',
          style: labelStyle,
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
