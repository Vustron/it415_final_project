// third party
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// flutter
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

SpinKitThreeBounce loading() {
  return const SpinKitThreeBounce(
    color: Color.fromARGB(255, 27, 240, 255),
    size: 60.0,
  );
}

AnimatedTextKit subtitle() {
  return AnimatedTextKit(
    animatedTexts: <AnimatedText>[
      WavyAnimatedText(
        'Made by BSIT-4C ❤️',
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
        speed: const Duration(milliseconds: 70),
      ),
    ],
  );
}

AnimatedTextKit title() {
  return AnimatedTextKit(
    animatedTexts: <AnimatedText>[
      ColorizeAnimatedText(
        'BabysitterApp',
        textStyle: const TextStyle(fontSize: 37, fontWeight: FontWeight.w900),
        colors: <Color>[
          Colors.black,
          const Color.fromARGB(255, 27, 240, 255),
        ],
      ),
    ],
  );
}
