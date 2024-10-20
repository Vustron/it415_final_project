// flutter
import 'package:flutter/material.dart';

Widget searchHeader() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'John Doe',
        ),
        Row(
          children: <Widget>[
            for (int i = 0; i < 5; i++)
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 12,
              ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Row(
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Color.fromARGB(127, 158, 158, 158),
              size: 15,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'Panabo City',
            )
          ],
        ),
      ],
    );
