import 'package:flutter/material.dart';

import 'package:babysitterapp/views/home.dart';

Widget topRatedBabySitterCard({
  required String networkImage,
  required String nameUser,
  required String ratePhp,
  required String starCount,
  required String reviewsCount,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topRatedBabySitter(
              networkImage: networkImage,
              nameUser: nameUser,
              ratePhp: ratePhp,
              starCount: starCount,
              reviewsCount: reviewsCount,
            ),
          ],
        ),
      ),
    );
