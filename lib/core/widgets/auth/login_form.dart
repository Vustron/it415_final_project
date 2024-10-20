// utils
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

// actions
import 'package:babysitterapp/core/helper/goto_page.dart';

// widgets
import 'package:babysitterapp/core/widgets/auth/account_check.dart';

// screens
import 'package:babysitterapp/views/auth/register.dart';
import 'package:babysitterapp/views/home/bottom_navbar.dart';

class LoginForm extends StatelessWidget with GlobalStyles {
  LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: GlobalStyles.kPrimaryColor,
            onSaved: (String? email) {},
            decoration: const InputDecoration(
              hintText: 'Your email',
              prefixIcon: Padding(
                padding: EdgeInsets.all(GlobalStyles.defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: GlobalStyles.defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: GlobalStyles.kPrimaryColor,
              decoration: const InputDecoration(
                hintText: 'Your password',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(GlobalStyles.defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
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
