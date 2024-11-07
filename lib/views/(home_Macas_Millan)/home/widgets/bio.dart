import 'package:flutter/material.dart';

Widget babySitterCardBio() => Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: 300,
      child: const Text(
        'A really long text string that will not fit within its box A really long text string that will not fit within its box',
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );
