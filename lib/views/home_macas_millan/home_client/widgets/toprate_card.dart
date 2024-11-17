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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
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
