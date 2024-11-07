import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helper/transition_home.dart';

import 'widgets/logo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    transitionHome(context);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

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
