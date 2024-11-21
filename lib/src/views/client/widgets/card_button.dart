import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers/router.dart';
import 'package:babysitterapp/src/views.dart';

Widget babySitterCardButton(
    BuildContext context, String name, String number, String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(FluentIcons.person_16_regular, size: 18),
            label: const Text(
              'View Profile',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {
              CustomRouter.navigateToWithTransition(
                Profile(),
                'rightToLeftWithFade',
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(
              FluentIcons.chat_16_regular,
              size: 18,
            ),
            label: const Text(
              'Message',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              CustomRouter.navigateToWithTransition(
                MessageDetailScreen(
                  name: name,
                  number: number,
                  image: image,
                ),
                'fade',
              );
            },
          ),
        ),
      ],
    ),
  );
}
