import 'package:flutter/material.dart';

Widget titleHeaderBabySitter(
  String title,
  void Function() fn,
  bool allowShowButton,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (allowShowButton)
            TextButton(
              onPressed: fn,
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
