//  utils
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

// TODO(Vustron): Replace the placeholder subtitle.
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
