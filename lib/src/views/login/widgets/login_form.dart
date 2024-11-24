import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final Toast toastRepository = ref.watch(toastProvider);

    useEffect(() {
      if (authState.status == AuthStatus.authenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          toastRepository.show(
            context: context,
            title: 'Success',
            message: 'Login success',
          );
          CustomRouter.navigateToWithTransition(
            const BottomNavbarView(),
            'fade',
          );
        });
      }
      return null;
    }, <Object?>[authState.status]);

    return Column(
      children: <Widget>[
        DynamicForm(
          fields: loginFields,
          onSubmit: (Map<String, dynamic> formData) async {
            try {
              final String email = formData['Email'] as String? ?? '';
              final String password = formData['Password'] as String? ?? '';

              await ref.read(authControllerProvider.notifier).login(
                    email: email,
                    password: password,
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
