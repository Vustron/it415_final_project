import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget with GlobalStyles {
  AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  final bool login;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an account ? " : 'Already have an account ? ',
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: GlobalStyles.primaryButtonColor,
            ),
          ),
        ),
      ],
    );
  }
}
