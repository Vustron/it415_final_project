import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers/router.dart';
import 'package:babysitterapp/src/views.dart';

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
      width: MediaQuery.of(context).size.width * 0.90,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          CustomRouter.navigateToWithTransition(
            Profile(),
            'rightToLeftWithFade',
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            babySitterCardHeader(
              networkImage: networkImage,
              nameUser: nameUser,
              ratePhp: ratePhp,
              locationUser: locationUser,
              starCount: starCount,
            ),
            Flexible(
              child: babySitterCardBio(context, userBio: userBio),
            ),
            babySitterCardButton(context, nameUser, number, image),
            // const SizedBox(height: 12),
          ],
        ),
      ),
    );
