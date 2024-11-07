import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

Widget topRatedBabySitter() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          radius: 30,
        ),
        const Column(
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
                Icon(
                  Icons.star,
                  size: 16,
                  color: Color.fromRGBO(255, 193, 7, 1),
                ),
                Text('4.5 / 808 reviews'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              color: Colors.pink,
              icon: const Icon(
                FluentIcons.heart_12_regular,
              ),
            )
          ],
        )
      ],
    );
