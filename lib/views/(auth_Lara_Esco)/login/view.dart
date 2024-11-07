import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helper/responsive.dart';

import 'widgets/mobile_login.dart';
import 'widgets/login_form.dart';
import 'widgets/background.dart';
import 'widgets/top_image.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginView(),
          desktop: Row(
            children: <Widget>[
              Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
