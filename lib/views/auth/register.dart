// utils
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/auth/signup_topimage.dart';
import 'package:babysitterapp/core/widgets/auth/social_signup.dart';
import 'package:babysitterapp/core/widgets/auth/signup_form.dart';
import 'package:babysitterapp/core/widgets/auth/background.dart';
import 'package:babysitterapp/core/helper/responsive.dart';

// views
import 'package:babysitterapp/views/auth/mobile_register.dart';

class RegisterView extends StatelessWidget with GlobalStyles {
  RegisterView({super.key});

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
