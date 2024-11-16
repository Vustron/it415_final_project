import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/home.dart';

Widget messageButton(Color colors, BuildContext context, String name,
        String number, String image) =>
    Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              goToPage(
                  context,
                  MessageDetailScreen(
                    name: name,
                    number: number,
                    image: image,
                  ),
                  'fade');
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
