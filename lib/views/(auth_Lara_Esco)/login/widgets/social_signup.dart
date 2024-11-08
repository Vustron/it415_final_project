import 'package:babysitterapp/core/constants/assets.dart';
import 'package:flutter/material.dart';

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
              iconSrc: googlePlusIcon,
              press: () {},
            ),
            SocalIcon(
              iconSrc: facebookIcon,
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}
