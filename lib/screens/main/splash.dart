// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/widgets/splash/subtitle.dart';
import 'package:babysitterapp/widgets/splash/loading.dart';
import 'package:babysitterapp/widgets/splash/title.dart';
import 'package:babysitterapp/widgets/splash/logo.dart';

// methods
import 'package:babysitterapp/actions/splash/transition_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
