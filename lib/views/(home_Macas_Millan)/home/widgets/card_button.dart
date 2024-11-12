import 'package:babysitterapp/views/(home_Macas_Millan)/message/widgets/detail.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/settings.dart';

Widget babySitterCardButton(
        BuildContext context, String name, String number, String image) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          TextButton(
            onPressed: () {
              goToPage(context, Profile(), 'rightToLeftWithFade');
            },
            child: const Text('View profile'),
          ),
          OutlinedButton(
            onPressed: () {
              goToPage(
                  context,
                  MessageDetailScreen(name: name, number: number, image: image),
                  'fade');
            },
            child: const Text('Message'),
          )
        ],
      ),
    );
