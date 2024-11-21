import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class OrDivider extends StatelessWidget with GlobalStyles {
  OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: GlobalStyles.smallPadding),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GlobalStyles.smallPadding),
            child: Text(
              'OR',
              style: labelStyle.copyWith(
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
