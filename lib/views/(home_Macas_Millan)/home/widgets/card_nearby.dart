import 'package:flutter/material.dart';

import 'package:babysitterapp/views/home.dart';

Widget babySitterCardNearby(
  BuildContext context, {
  required String networkImage,
  required String nameUser,
  required String ratePhp,
  required String locationUser,
  required String starCount,
  required String userBio,
}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          babySitterCardHeader(
            networkImage: networkImage,
            nameUser: nameUser,
            ratePhp: ratePhp,
            locationUser: locationUser,
            starCount: starCount,
          ),
          babySitterCardBio(
            context,
            userBio: userBio,
          ),
          babySitterCardButton(context),
        ],
      ),
    );
