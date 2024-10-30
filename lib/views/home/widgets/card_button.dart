// flutter
import 'package:flutter/material.dart';

Widget babySitterCardButton() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: const Text('View profile'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('Message'),
        )
      ],
    );
