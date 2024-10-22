// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/splash/subtitle.dart';
import 'package:babysitterapp/core/widgets/splash/loading.dart';
import 'package:babysitterapp/core/widgets/splash/title.dart';
import 'package:babysitterapp/core/widgets/splash/logo.dart';

// methods
import 'package:babysitterapp/core/helper/transition_home.dart';

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
    // ini media query size
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          logo(),
          Positioned(
            bottom: mq.height * .28,
            width: mq.width,
            // duration: const Duration(seconds: 1),
            child: Center(
              child: Column(
                children: <Widget>[
                  title(),
                  subtitle(),
                  const SizedBox(height: 30),
                  loading(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
