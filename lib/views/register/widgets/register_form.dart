// core
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

// widgets
import 'package:babysitterapp/views/login/widgets/account_check.dart';
import 'package:babysitterapp/views/login/widgets/mobile_login.dart';

// views
import 'package:babysitterapp/views/home/bottom_navbar.dart';

// flutter
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget with GlobalStyles {
  RegisterForm({
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
          const SizedBox(height: GlobalStyles.defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              goToPage(
                  context, const BottomNavbarView(), 'rightToLeftWithFade');
            },
            child: Text('Sign Up'.toUpperCase()),
          ),
          const SizedBox(height: GlobalStyles.defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              goToPage(context, const MobileLoginView(), 'rightToLeftWithFade');
            },
          ),
        ],
      ),
    );
  }
}
