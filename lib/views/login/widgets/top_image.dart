// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

class LoginScreenTopImage extends StatelessWidget with GlobalStyles {
  LoginScreenTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'LOGIN',
          style: headerStyle, 
        ),
        const SizedBox(height:  GlobalStyles.defaultPadding * 2), 
      ],
    );
  }
}
