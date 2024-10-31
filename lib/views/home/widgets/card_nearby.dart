// core
import 'card_button.dart';
import 'card_header.dart';
import 'bio.dart';

// flutter
import 'package:flutter/material.dart';

Widget babySitterCardNearby(BuildContext context) => SizedBox(
      width: 360,
      child: Card(
        color: const Color.fromRGBO(237, 237, 241, 1),
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
      ),
    );
