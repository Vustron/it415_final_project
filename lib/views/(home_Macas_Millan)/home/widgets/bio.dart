import 'package:flutter/material.dart';

Widget babySitterCardBio(BuildContext context, {required String userBio}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        userBio,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    );
