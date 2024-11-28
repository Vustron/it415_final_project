import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';

Widget babySitterHeader({
  required String username,
  required String networkImage,
  required String location,
  required String starRatings,
  required bool onlineStatus,
  required bool isVerified,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedAvatar(
                imageUrl: networkImage,
                showOnlineStatus: true,
                isOnline: onlineStatus,
                showVerificationStatus: true,
                isVerified: isVerified,
              ),
              const SizedBox(height: 10),
              Text(
                username,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'Your Total Ratings',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.star,
                    size: 50,
                    color: Colors.yellow,
                  ),
                  Text(
                    starRatings,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
