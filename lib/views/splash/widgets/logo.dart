import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/assets.dart';

late Size mq;

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(logo).animate().scale(
                duration: 600.ms,
                curve: Curves.easeOutBack,
                begin: const Offset(0.2, 0.2),
                end: const Offset(1.0, 1.0),
              ),
        ),
      ),
    );
  }
}
