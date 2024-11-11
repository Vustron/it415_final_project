import 'package:flutter/material.dart';

Widget babySitterCardBio(BuildContext context, {required String userBio}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
      child: Text(
        userBio,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 3,
        style: const TextStyle(fontSize: 13),
      ),
    );
