import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class RegisterView extends HookWidget with GlobalStyles {
  RegisterView({super.key});

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

    return BackgroundContainer(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 90),
                Text(
                  'Create an Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Fill in the details to create an account',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: RegisterForm(),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    showTermsAndConditions(context);
                  },
                  child: Text(
                    'Terms and Conditions',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          color: GlobalStyles.primaryButtonColor,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialButton(
                      icon: 'assets/icons/google.png',
                      onPressed: () {
                        // Implement Google login
                      },
                      label: 'Continue with Google',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
