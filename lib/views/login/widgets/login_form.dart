// core
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/core/components/input.dart';

// flutter
import 'package:flutter/material.dart';

// widgets
import 'account_check.dart';

// views
import 'package:babysitterapp/views/register/view.dart';
import 'package:babysitterapp/views/home/widgets/bottom_navbar.dart';

class LoginForm extends StatelessWidget with GlobalStyles {
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          SizedBox( // Wrap in a Container
            height: GlobalStyles.defaultSize, // Set the height here
            child: CustomTextInput(
              onChanged: (String value) {},
              onClear: () {},
              prefixIcon: const Icon(
                Icons.mail,
                size: GlobalStyles.defaultIconSize, // Use GlobalStyles for icon size
              ),
              hintText: 'Enter your email address',
              textInputAction: TextInputAction.next,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: GlobalStyles.defaultPadding,
            ),
            child: SizedBox( // Wrap in a Container
              height: GlobalStyles.defaultSize, // Set the height here
              child: CustomTextInput(
                onChanged: (String value) {},
                onClear: () {},
                prefixIcon: const Icon(
                  Icons.lock,
                  size: GlobalStyles.defaultIconSize, // Use GlobalStyles for icon size
                ),
                hintText: 'Enter your password',
                obscureText: true,
                cursorColor: GlobalStyles.primaryButtonColor,
              ),
            ),
          ),
          const SizedBox(height: GlobalStyles.defaultPadding),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalStyles.primaryButtonColor,
              padding: const EdgeInsets.symmetric(
                vertical: GlobalStyles.defaultPadding / 1.5,
                horizontal: GlobalStyles.defaultPadding * 2,
              ),
              textStyle: labelStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              goToPage(context, const BottomNavbarView(), 'rightToLeftWithFade');
            },
            child: Text(
              'Login'.toUpperCase(),
              style: labelStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
