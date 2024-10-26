// third party
import 'package:flutter_svg/flutter_svg.dart';

// core
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

// views
import 'package:babysitterapp/views/home/bottom_navbar.dart';
import 'package:babysitterapp/views/auth/login/screen.dart';
import 'package:babysitterapp/views/auth/login/views.dart';

// flutter
import 'package:flutter/material.dart';

class MobileRegisterView extends StatelessWidget {
  const MobileRegisterView({
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

class SignUpScreenTopImage extends StatelessWidget with GlobalStyles {
  SignUpScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Sign Up'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset('assets/icons/signup.svg'),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
      ],
    );
  }
}

class SignUpForm extends StatelessWidget with GlobalStyles {
  SignUpForm({
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
              goToPage(context, const LoginScreen(), 'rightToLeftWithFade');
            },
          ),
        ],
      ),
    );
  }
}
