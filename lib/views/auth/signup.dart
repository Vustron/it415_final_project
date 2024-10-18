// utils
import 'package:babysitterapp/utils/styles.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/widgets/auth/signup_topimage.dart';
import 'package:babysitterapp/widgets/auth/social_signup.dart';
import 'package:babysitterapp/widgets/auth/signup_form.dart';
import 'package:babysitterapp/widgets/auth/background.dart';
import 'package:babysitterapp/utils/responsive.dart';

class SignUpScreen extends StatelessWidget with GlobalStyles {
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileSignupScreen(),
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

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
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
