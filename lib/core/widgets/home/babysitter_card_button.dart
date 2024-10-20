// utils
import 'package:flutter/material.dart';

Widget babySitterCardButton() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
          ),
          child: const Text('View profile'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.lightBlue),
            foregroundColor: Colors.lightBlue,
          ),
          child: const Text('Message'),
        )
      ],
    );
