// utils
import 'package:babysitterapp/utils/styles.dart';
import 'package:flutter/material.dart';

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
          login ? "Don't have an Account ? " : 'Already have an Account ? ',
          style: const TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? 'Sign Up' : 'Sign In',
            style: const TextStyle(
              color: GlobalStyles.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
