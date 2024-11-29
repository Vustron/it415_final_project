import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

Widget messageButton(Color colors, BuildContext context, String name,
        String number, String image, String recipientId) =>
    Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              CustomRouter.navigateToWithTransition(
                MessageDetailScreen(
                  name: name,
                  number: number,
                  image: image,
                  recipientId: recipientId,
                ),
                'fade',
              );
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: colors,
                minimumSize: const Size.fromHeight(40)),
            child: const Text('Message'),
          ),
        ),
        const SizedBox(width: 15),
        const Expanded(
            child: Text(
          'P 300.00/hr',
          style: TextStyle(fontWeight: FontWeight.bold),
        ))
      ],
    );
