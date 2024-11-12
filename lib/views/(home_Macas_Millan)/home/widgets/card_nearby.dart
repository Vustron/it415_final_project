import 'package:flutter/material.dart';

import 'package:babysitterapp/views/home.dart';
// Sample data; replace with actual user data from your app's state
const String userName = 'Carole Howell';
const String userNumber = '0956-625-2536';
const String userImage = 'assets/images/hippo.png'; // Update with actual image
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
          babySitterCardButton(context,userName,userNumber,userImage)
        ],
      ),
    );
