import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/settings.dart';

Widget babySitterCardButton(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: () {
                goToPage(context, Profile(), 'rightToLeftWithFade');
              },
              child: const Text('View profile'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Message'),
            ),
          ),
        ],
      ),
    );
