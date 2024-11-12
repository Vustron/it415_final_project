import 'package:flutter/material.dart';

import 'package:babysitterapp/views/home.dart';

Widget babySitterCardNearby(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 340,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            babySitterCardHeader(),
            babySitterCardBio(),
            babySitterCardButton(context),
          ],
        ),
      ),
    );
