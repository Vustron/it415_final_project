// utils
import 'package:babysitterapp/utils/styles.dart';
import 'package:flutter/material.dart';

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
        // Row(
        //   children: [
        //     Spacer(),
        //     Expanded(
        //       flex: 8,
        //       child: SvgPicture.asset("assets/icons/login.svg"),
        //     ),
        //     Spacer(),
        //   ],
        // ),
        SizedBox(height: GlobalStyles.defaultPadding * 2),
      ],
    );
  }
}
