import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
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

    ref.listen<AuthState>(
      authControllerProvider,
      (AuthState? previous, AuthState next) {
        if (!next.hasShownToast) {
          switch (next.status) {
            case AuthStatus.authenticated:
              toastification.dismissAll();
              ToastUtils.showToast(
                context: context,
                title: 'Success',
                message: 'Registration successful',
                type: ToastificationType.success,
              );

              ref.read(authControllerProvider.notifier).markToastAsShown();
              CustomRouter.navigateToWithTransition(
                const BottomNavbarView(),
                'rightToLeftWithFade',
              );
              break;

            case AuthStatus.error:
              if (next.error != null) {
                toastification.dismissAll();
                ToastUtils.showToast(
                  context: context,
                  title: 'Error',
                  message: next.error!,
                  type: ToastificationType.error,
                );

                ref.read(authControllerProvider.notifier).markToastAsShown();
              }
              break;

            default:
              break;
          }
        }
      },
    );

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
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(authControllerProvider.notifier).register(
                        name: formData['Name']!,
                        email: formData['Email']!,
                        password: formData['Password']!,
                        role: formData['Type of account']!,
                      );
                },
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: fields,
          onSubmit: (Map<String, dynamic> formData) => showConfirmationDialog(
            context,
            formData.cast<String, String>(),
          ),
          isLoading: ValueNotifier<bool>(authState.isLoading),
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
        AlreadyHaveAnAccountCheck(
          login: false,
          press: () {
            CustomRouter.navigateToWithTransition(
              const LoginView(),
              'leftToRightWithFade',
            );
          },
        ),
      ],
    );
  }
}
