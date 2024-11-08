import 'package:babysitterapp/controllers/authentication_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/state/authentication_state.dart';
import 'package:babysitterapp/core/components/dynamic_form.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'package:babysitterapp/models/user_account.dart';
import 'package:babysitterapp/models/inputfield.dart';

import 'package:babysitterapp/views/(auth_Lara_Esco)/login/widgets/account_check.dart';
import 'package:babysitterapp/views/(auth_Lara_Esco)/login/view.dart';

class RegisterForm extends HookConsumerWidget with GlobalStyles {
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);

    ref.listen(authController,
        (AuthenticationState? previous, AuthenticationState next) {
      next.maybeWhen(
        orElse: () => isLoading.value = false,
        authenticated: (UserAccount user) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Authenticated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          isLoading.value = false;
        },
        unauthenticated: (String? message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message!),
              behavior: SnackBarBehavior.floating,
            ),
          );
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

    void onSubmit(Map<String, String> formData) {
      ref.read(authController.notifier).signup(
            name: formData['Name']!,
            email: formData['Email']!,
            password: formData['Password']!,
            role: formData['Type of account']!,
          );
      isLoading.value = true;
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
