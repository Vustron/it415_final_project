import 'package:flutter/material.dart';

class MarkerIcon extends StatelessWidget {
  const MarkerIcon({super.key, required this.images, required this.color});

  final String images;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: color,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(100)),
            padding: const EdgeInsets.all(6),
            child: CircleAvatar(
              backgroundImage: AssetImage(images),
            ),
          )),
    );
  }
}
