import 'package:flutter/material.dart';

Widget messageButton(Color colors) => Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: colors,
                minimumSize: const Size.fromHeight(50)),
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
