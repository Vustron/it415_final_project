import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class LoginForm extends HookConsumerWidget with GlobalStyles {
  LoginForm({super.key});

  final List<InputFieldConfig> loginFields = <InputFieldConfig>[
    const InputFieldConfig(
      label: 'Email',
      hintText: 'Enter your email address',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: FluentIcons.mail_20_regular,
      type: 'email',
    ),
    const InputFieldConfig(
      label: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      prefixIcon: FluentIcons.lock_closed_20_regular,
      type: 'password',
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
                message: 'Login successful',
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

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: loginFields,
          onSubmit: (Map<String, dynamic> formData) {
            final String email = formData['Email'] as String? ?? '';
            final String password = formData['Password'] as String? ?? '';
            ref.read(authControllerProvider.notifier).login(
                  email: email,
                  password: password,
                );
          },
          isLoading: ValueNotifier<bool>(authState.isLoading),
        ),
        const SizedBox(height: GlobalStyles.defaultPadding),
        AlreadyHaveAnAccountCheck(
          press: () {
            CustomRouter.navigateToWithTransition(
              RegisterView(),
              'rightToLeftWithFade',
            );
          },
        ),
      ],
    );
  }
}
