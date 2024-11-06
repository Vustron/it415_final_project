// core
import 'toprate.dart';

// flutter
import 'package:flutter/material.dart';

Widget topRatedBabySitterCard() => Container(
      width: 340,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topRatedBabySitter(),
          ],
        ),
      ),
    );
