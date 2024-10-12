// utils
import 'package:flutter/material.dart';

Widget findButton() {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.search),
      label: const Text('Find a nanny!'),
    ),
  );
}
