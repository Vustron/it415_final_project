import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/settings.dart';

class MarkerIcon extends HookWidget {
  const MarkerIcon({super.key, required this.images, required this.color});

  final String images;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final AnimationController pulseController = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    final Animation<double> pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: pulseController,
        curve: Curves.easeInOut,
      ),
    );

    return GestureDetector(
      onTap: () {
        goToPage(context, Profile(), 'rightToLeft');
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: pulseAnimation,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundImage: AssetImage(images),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
