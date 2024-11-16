import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/auth.dart';

class ErrorView extends HookWidget {
  const ErrorView({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
      ));
      return null;
    }, <Object?>[]);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64.0,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                    ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  goToPage(
                    context,
                    const LoginView(),
                    'rightToLeftWithFade',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalStyles.primaryButtonColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
