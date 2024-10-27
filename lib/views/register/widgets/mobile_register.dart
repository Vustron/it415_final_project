// flutter
import 'package:flutter/material.dart';

// widgets
import 'register_form.dart';
import 'top_image.dart';

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
              child: RegisterForm(),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
