// core
import 'package:babysitterapp/core/helper/responsive.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// widgets
import 'package:babysitterapp/views/auth/login/widgets/social_signup.dart';
import 'package:babysitterapp/views/auth/login/widgets/background.dart';
import 'widgets/mobile_register.dart';
import 'widgets/register_form.dart';
import 'widgets/top_image.dart';

// flutter
import 'package:flutter/material.dart';

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
                      child: RegisterForm(),
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
