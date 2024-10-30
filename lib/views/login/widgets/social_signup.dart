// flutter
import 'package:flutter/material.dart';

// widgets
import 'social_icon.dart';
import 'divider.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSrc: 'assets/icons/google-plus.svg',
              press: () {},
            ),
            SocalIcon(
              iconSrc: 'assets/icons/facebook.svg',
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}
