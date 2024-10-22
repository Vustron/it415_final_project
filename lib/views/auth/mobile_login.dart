// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/auth/login_topimage.dart';
import 'package:babysitterapp/core/widgets/auth/social_signup.dart';
import 'package:babysitterapp/core/widgets/auth/login_form.dart';

class MobileLoginView extends StatelessWidget {
  const MobileLoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            const Spacer(),
          ],
        ),
        const SocialSignUp()
      ],
    );
  }
}
