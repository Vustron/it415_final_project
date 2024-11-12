import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

Widget babySitterCardHeader({
  required String networkImage,
  required String nameUser,
  required String ratePhp,
  required String locationUser,
  required String starCount,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(networkImage),
            radius: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        nameUser,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '₱$ratePhp/hr',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(FluentIcons.location_12_filled, size: 14),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        locationUser,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.star,
                size: 16,
                color: Color.fromRGBO(255, 193, 7, 1),
              ),
              Text(
                starCount,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          )
        ],
      ),
    );
