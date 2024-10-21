// core
import 'package:babysitterapp/core/widgets/auth/account_check.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/widgets/ui/input.dart';

// flutter
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/home/bottom_navbar.dart';
import 'package:babysitterapp/views/auth/register.dart';

class LoginForm extends StatelessWidget with GlobalStyles {
  LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          CustomTextInput(
            onChanged: (String value) {},
            onClear: () {},
            prefixIcon: const Icon(Icons.mail),
            hintText: 'Enter your email address',
            textInputAction: TextInputAction.next,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: GlobalStyles.defaultPadding),
            child: CustomTextInput(
              onChanged: (String value) {},
              onClear: () {},
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter your password',
              obscureText: true,
              cursorColor: GlobalStyles.primaryButtonColor,
            ),
          ),
          const SizedBox(height: GlobalStyles.defaultPadding),
          ElevatedButton(
            onPressed: () {
              goToPage(
                  context, const BottomNavbarView(), 'rightToLeftWithFade');
            },
            child: Text(
              'Login'.toUpperCase(),
            ),
          ),
          const SizedBox(height: GlobalStyles.defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              goToPage(context, RegisterView(), 'rightToLeftWithFade');
            },
          ),
        ],
      ),
    );
  }
}
