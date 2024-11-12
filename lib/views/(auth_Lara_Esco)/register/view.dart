import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/auth.dart';

class RegisterView extends StatelessWidget with GlobalStyles {
  RegisterView({super.key});

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
