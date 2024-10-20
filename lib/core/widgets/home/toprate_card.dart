// core
import 'toprate.dart';

// flutter
import 'package:flutter/material.dart';

Widget topRatedBabySitterCard() => SizedBox(
      width: 360,
      child: Card(
        color: const Color.fromRGBO(237, 237, 241, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              topRatedBabySitter(),
            ],
          ),
        ),
      ),
    );
