// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/auth/login_topimage.dart';
import 'package:babysitterapp/core/widgets/auth/login_form.dart';
import 'package:babysitterapp/core/widgets/auth/background.dart';
import 'package:babysitterapp/core/helper/responsive.dart';

// views
import 'package:babysitterapp/views/auth/mobile_login.dart';

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
