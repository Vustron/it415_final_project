// third party
import 'package:flutter_svg/flutter_svg.dart';

// core
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/core/widgets/ui/input.dart';

// flutter
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/auth/register/screen.dart';
import 'package:babysitterapp/views/home/bottom_navbar.dart';

class MobileLoginView extends StatelessWidget {
  const MobileLoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoginScreenTopImage(),
        Row(
          children: <Widget>[
            const Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            const Spacer(),
          ],
        ),
        const SocialSignUp()
      ],
    );
  }
}

class LoginScreenTopImage extends StatelessWidget with GlobalStyles {
  LoginScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text(
          'LOGIN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: GlobalStyles.defaultPadding * 2),
      ],
    );
  }
}

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocalIcon(
              iconSrc: 'assets/icons/google-plus.svg',
              press: () {},
            ),
            SocalIcon(
              iconSrc: 'assets/icons/facebook.svg',
              press: () {},
            ),
          ],
        ),
      ],
    );
  }
}

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
              goToPage(context, RegisterScreen(), 'rightToLeftWithFade');
            },
          ),
        ],
      ),
    );
  }
}

class SocalIcon extends StatelessWidget with GlobalStyles {
  SocalIcon({
    super.key,
    this.iconSrc,
    this.press,
  });

  final String? iconSrc;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: GlobalStyles.kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc!,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget with GlobalStyles {
  OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'OR',
              style: TextStyle(
                color: GlobalStyles.kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget with GlobalStyles {
  AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  final bool login;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ? " : 'Already have an Account ? ',
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? 'Sign Up' : 'Sign In',
          ),
        )
      ],
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.child,
    this.topImage = mainTopBg,
    this.bottomImage = mainBottomBg,
  });

  final Widget child;
  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(bottomImage, width: 120),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
