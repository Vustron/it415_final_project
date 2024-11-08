import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components/dynamic_form.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'package:babysitterapp/models/inputfield.dart';

import 'package:babysitterapp/views/(auth_Lara_Esco)/login/widgets/account_check.dart';
import 'package:babysitterapp/views/(auth_Lara_Esco)/login/view.dart';

class RegisterForm extends HookWidget with GlobalStyles {
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
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
        options: <String>[
          'Babysitter',
          'Client'
        ], // Add options for the select field
      ),
    ];

    void onSubmit(Map<String, String> formData) {
      goToPage(context, const LoginView(), 'rightToLeftWithFade');
    }

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: fields,
          onSubmit: onSubmit,
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
