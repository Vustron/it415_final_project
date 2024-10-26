// core
import 'package:babysitterapp/core/helper/responsive.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// views
import 'package:babysitterapp/views/auth/register/views.dart';
import 'package:babysitterapp/views/auth/login/views.dart';

// flutter
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget with GlobalStyles {
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileRegisterView(),
          desktop: Row(
            children: <Widget>[
              Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 450,
                      child: SignUpForm(),
                    ),
                    const SizedBox(height: GlobalStyles.defaultPadding / 2),
                    const SocialSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
