// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/auth/signup_topimage.dart';
import 'package:babysitterapp/core/widgets/auth/signup_form.dart';

class MobileRegisterView extends StatelessWidget {
  const MobileRegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignUpScreenTopImage(),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
