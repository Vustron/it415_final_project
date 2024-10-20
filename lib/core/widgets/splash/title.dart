// third party
import 'package:animated_text_kit/animated_text_kit.dart';

// flutter
import 'package:flutter/material.dart';

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
