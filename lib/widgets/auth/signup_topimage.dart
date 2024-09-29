// utils
import 'package:babysitterapp/utils/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SignUpScreenTopImage extends StatelessWidget with GlobalStyles {
  SignUpScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
