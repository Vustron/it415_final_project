import 'package:flutter/material.dart';

import 'package:babysitterapp/views/home.dart';

const String userName = 'Carole Howell';
const String userNumber = '0956-625-2536';
const String userImage = 'assets/images/hippo.png';

Widget babySitterCardNearby(
  BuildContext context, {
  required String networkImage,
  required String nameUser,
  required String ratePhp,
  required String locationUser,
  required String starCount,
  required String userBio,
  required String name,
  required String number,
  required String image,
}) =>
    Container(
      width: MediaQuery.of(context).size.width * 0.85,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.28,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: babySitterCardHeader(
              networkImage: networkImage,
              nameUser: nameUser,
              ratePhp: ratePhp,
              locationUser: locationUser,
              starCount: starCount,
            ),
          ),
          Expanded(
            flex: 2,
            child: babySitterCardBio(
              context,
              userBio: userBio,
            ),
          ),
          Expanded(
            flex: 2,
            child:
                babySitterCardButton(context, userName, userNumber, userImage),
          ),
        ],
      ),
    );
