import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class RegisterForm extends HookConsumerWidget with GlobalStyles {
  RegisterForm({super.key});

  final List<InputFieldConfig> fields = <InputFieldConfig>[
    const InputFieldConfig(
      label: 'Name',
      hintText: 'Your name',
      keyboardType: TextInputType.text,
      prefixIcon: FluentIcons.person_20_regular,
      type: 'text',
    ),
    const InputFieldConfig(
      label: 'Email',
      hintText: 'Your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: FluentIcons.mail_20_regular,
      type: 'email',
    ),
    const InputFieldConfig(
      label: 'Password',
      hintText: 'Your password',
      obscureText: true,
      prefixIcon: FluentIcons.lock_closed_20_regular,
      type: 'password',
    ),
    const InputFieldConfig(
      label: 'Type of account',
      hintText: 'Select your type of account',
      keyboardType: TextInputType.text,
      prefixIcon: FluentIcons.person_accounts_20_regular,
      type: 'select',
      options: <String>['Babysitter', 'Client'],
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerProvider);
    final ToastRepository toastRepository = ref.watch(toastProvider);

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: fields,
          onSubmit: (Map<String, dynamic> formData) async {
            try {
              await ref.read(authControllerProvider.notifier).register(
                    name: formData['Name'] as String,
                    email: formData['Email'] as String,
                    password: formData['Password'] as String,
                    role: formData['Type of account'] as String,
                  );

              if (context.mounted) {
                final AuthState updatedAuthState =
                    ref.read(authControllerProvider);

                if (updatedAuthState.error != null) {
                  toastRepository.show(
                    context: context,
                    title: 'Error',
                    message: updatedAuthState.error!,
                    type: 'error',
                  );
                } else if (updatedAuthState.status ==
                    AuthStatus.authenticated) {
                  toastRepository.show(
                    context: context,
                    title: 'Success',
                    message: 'Registered successfully',
                  );
                  CustomRouter.navigateToWithTransition(
                    const BottomNavbarView(),
                    'fade',
                  );
                }
              }
            } catch (e) {
              if (context.mounted) {
                toastRepository.show(
                  context: context,
                  title: 'Error',
                  message: e.toString(),
                  type: 'error',
                );
              }
            }
          },
          isLoading: ValueNotifier<bool>(authState.isLoading),
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
        AlreadyHaveAnAccountCheck(
          login: false,
          press: () {
            CustomRouter.navigateToWithTransition(
              LoginView(),
              'leftToRightWithFade',
            );
          },
        ),
      ],
    );
  }
}
