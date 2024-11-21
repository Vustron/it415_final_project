import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class SplashView extends HookWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      transitionHome(context);
      return null;
    }, <Object?>[]);

    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const AnimatedLogo(),
          Positioned(
            bottom: mq.height * .28,
            width: mq.width,
            child: const Center(
              child: Column(),
            ),
          ),
        ],
      ),
    );
  }
}
