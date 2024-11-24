import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class LogoutButton extends HookConsumerWidget with GlobalStyles {
  LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final Toast toastRepository = ref.watch(toastProvider);

    Future<void> handleLogout() async {
      try {
        isLoading.value = true;

        await ref.read(authControllerProvider.notifier).logout();

        if (context.mounted) {
          final AuthState updatedAuthState = ref.read(authControllerProvider);

          if (updatedAuthState.error != null) {
            toastRepository.show(
              context: context,
              title: 'Error',
              message: updatedAuthState.error!,
              type: 'error',
            );
          } else {
            toastRepository.show(
              context: context,
              title: 'Success',
              message: 'Logged out successfully',
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
      } finally {
        isLoading.value = false;
      }
    }

    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  final bool confirmed =
                      (await showLogoutDialog(context)) ?? false;
                  if (confirmed) {
                    await handleLogout();
                  }
                },
          style: TextButton.styleFrom(
            backgroundColor: isLoading.value
                ? GlobalStyles.primaryButtonColor.withOpacity(0.7)
                : GlobalStyles.primaryButtonColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
