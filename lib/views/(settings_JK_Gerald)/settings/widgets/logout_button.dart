import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/core/constants/styles.dart';

import 'package:babysitterapp/controllers/authentication_controller.dart';

import 'package:babysitterapp/views/(auth_Lara_Esco)/login/view.dart';

class LogoutButton extends HookConsumerWidget with GlobalStyles {
  LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  isLoading.value = true;
                  await ref.read(authController.notifier).logout();
                  isLoading.value = false;

                  if (context.mounted) {
                    goToPage(context, const LoginView(), 'rightToLeftWithFade');
                  }
                },
          style: TextButton.styleFrom(
            backgroundColor: GlobalStyles.primaryButtonColor,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Log out', style: TextStyle(color: Colors.white)),
                  ],
                ),
        ),
      ),
    );
  }
}
