import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/user_account.dart';
import 'package:babysitterapp/models/inputfield.dart';

import 'package:babysitterapp/views/auth.dart';

class RegisterForm extends HookConsumerWidget with GlobalStyles {
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<bool> snackbarShown = useState(false);

    ref.listen(authController,
        (AuthenticationState? previous, AuthenticationState next) {
      next.maybeWhen(
        orElse: () {
          isLoading.value = false;
          snackbarShown.value = false;
        },
        authenticated: (UserAccount user) {
          if (!snackbarShown.value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User Authenticated'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            snackbarShown.value = true;
          }
          isLoading.value = false;
        },
        unauthenticated: (String? message) {
          if (!snackbarShown.value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message!),
                behavior: SnackBarBehavior.floating,
              ),
            );
            snackbarShown.value = true;
          }
          isLoading.value = false;
        },
      );
    });

    final List<InputFieldConfig> fields = <InputFieldConfig>[
      InputFieldConfig(
        label: 'Name',
        hintText: 'Your name',
        keyboardType: TextInputType.text,
        prefixIcon: Icons.person,
        type: 'text',
      ),
      InputFieldConfig(
        label: 'Email',
        hintText: 'Your email',
        keyboardType: TextInputType.emailAddress,
        prefixIcon: Icons.email,
        type: 'email',
      ),
      InputFieldConfig(
        label: 'Password',
        hintText: 'Your password',
        obscureText: true,
        prefixIcon: Icons.lock,
        type: 'password',
      ),
      InputFieldConfig(
        label: 'Type of account',
        hintText: 'Select your type of account',
        keyboardType: TextInputType.text,
        prefixIcon: Icons.person,
        type: 'select',
        options: <String>['Babysitter', 'Client'],
      ),
    ];

    Future<void> showConfirmationDialog(
        BuildContext context, Map<String, String> formData) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Your Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name: ${formData['Name']}'),
                Text('Email: ${formData['Email']}'),
                Text('Type of account: ${formData['Type of account']}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  isLoading.value = false;
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(authController.notifier).register(
                        name: formData['Name']!,
                        email: formData['Email']!,
                        password: formData['Password']!,
                        role: formData['Type of account']!,
                      );
                  isLoading.value = true;
                  snackbarShown.value = false; // Reset the flag on submit
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    }

    void onSubmit(Map<String, String> formData) {
      showConfirmationDialog(context, formData);
    }

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: fields,
          onSubmit: onSubmit,
          isLoading: isLoading,
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
        AlreadyHaveAnAccountCheck(
          login: false,
          press: () {
            goToPage(context, const LoginView(), 'leftToRightWithFade');
          },
        ),
      ],
    );
  }
}
