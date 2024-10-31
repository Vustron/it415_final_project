// flutter
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/views/babysitter_profile/view.dart';
import 'package:flutter/material.dart';

Widget babySitterCardButton(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: () {
            goToPage(context, const BabysitterProfile(), 'rightToLeftWithFade');
          },
          child: const Text('View profile'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Message'),
        )
      ],
    );
