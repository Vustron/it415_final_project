// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/home/babysitter_card_button.dart';
import 'package:babysitterapp/core/widgets/home/babysitter_card_header.dart';
import 'package:babysitterapp/core/widgets/home/babysitter_bio.dart';

Widget babySitterCardNearby() => SizedBox(
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
              babySitterCardButton(),
            ],
          ),
        ),
      ),
    );
