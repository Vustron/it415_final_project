import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class DescriptionsPage extends StatelessWidget with GlobalStyles {
  DescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        Text(
          textAlign: TextAlign.justify,
          "Hi! I'm Carolle Howell, a dedicated and caring babysitter with over five years of experience working with children aged 2-12. I have a passion for creating a safe and engaging environment where kids can have fun while learning. I'm also CPR and First Aid certified, so you can have peace of mind knowing your child is in safe hands.",
          style: labelStyle,
        ),
        const SizedBox(
          height: GlobalStyles.defaultPadding,
        ),
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '150',
                  style: labelStyle,
                ),
                const SizedBox(
                  width: GlobalStyles.smallPadding,
                ),
                Text(
                  'Reviews',
                  style: labelStyle,
                ),
              ],
            ),
            const SizedBox(
              width: GlobalStyles.smallPadding,
            ),
            Text(
              '•',
              style: labelStyle,
            ),
            const SizedBox(
              width: GlobalStyles.smallPadding,
            ),
            Row(
              children: <Widget>[
                for (int i = 0; i < 5; i++)
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
              ],
            ),
            const SizedBox(
              width: GlobalStyles.smallPadding,
            ),
            Text(
              '5.0',
              style: labelStyle,
            )
          ],
        ),
      ],
    );
  }
}
