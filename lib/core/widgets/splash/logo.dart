// utils
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';

late Size mq;

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/placeholder_logo.png').animate().scale(
          duration: 600.ms,
          curve: Curves.easeOutBack,
          begin: const Offset(0.2, 0.2),
          end: const Offset(1.0, 1.0),
        );
  }
}

Positioned logo() {
  return Positioned(
    top: mq.height * .33,
    right: mq.width * .25,
    width: mq.width * .5,
    child: const AnimatedLogo(),
  );
}
