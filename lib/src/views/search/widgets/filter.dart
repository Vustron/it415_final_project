import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

Widget buttons(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Maps',
            ),
            icon: const Icon(
              FluentIcons.map_24_regular,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              CustomRouter.navigateToWithTransition(
                FilterView(),
                'rightToLeftWithFade',
              );
            },
            label: const Text(
              'Filter',
            ),
            icon: const Icon(
              FluentIcons.filter_24_regular,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
