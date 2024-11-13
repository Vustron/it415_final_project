import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    // Exit full-screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                Image.asset(
                  logo,
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please login to your account',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
