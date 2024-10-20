// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatelessWidget with GlobalStyles {
  LoginScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text(
          'LOGIN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: GlobalStyles.defaultPadding * 2),
      ],
    );
  }
}
