import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

Widget babySitterCardHeader() => const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          radius: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Ms. Jen Mea',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text('₱ 210/hr'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(FluentIcons.location_12_filled, size: 14),
                Text('Panabo City'),
              ],
            ),
          ],
        ),
      ],
    );
