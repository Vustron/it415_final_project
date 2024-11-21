import 'package:toastification/toastification.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class EditProfileView extends HookConsumerWidget with GlobalStyles {
  EditProfileView({super.key, required this.user});
  final UserAccount? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final double profileCompletion = calculateProfileCompletion(user!);
    final AuthController authController =
        ref.watch(authControllerProvider.notifier);

    ref.listen(authControllerProvider, (AuthState? previous, AuthState next) {
      if (!next.hasShownToast && context.mounted) {
        toastification.dismissAll();
        if (next.error != null) {
          ToastUtils.showToast(
            context: context,
            title: 'Error',
            message: next.error!,
            type: ToastificationType.error,
          );
        } else if (next.status == AuthStatus.authenticated) {
          ToastUtils.showToast(
            context: context,
            title: 'Success',
            message: 'Profile updated successfully',
          );
        }
        ref.read(authControllerProvider.notifier).markToastAsShown();
      }
    });

    Future<void> onSubmit(Map<String, dynamic> formData) async {
      try {
        isLoading.value = true;
        String? newProfileImgUrl;
        String? newValidIdUrl;

        // Handle profile image
        if (formData['Profile Image'] != null) {
          final dynamic imageData = formData['Profile Image'];
          if (imageData is String) {
            newProfileImgUrl = imageData;
          }
        }

        if (formData['Valid ID'] != null) {
          final dynamic validIdImageData = formData['Valid ID'];
          if (validIdImageData is String) {
            newValidIdUrl = validIdImageData;
          }
        }

        final UserAccount updatedUser = UserAccount(
          id: user?.id ?? '',
          name: formData['Name'] as String? ?? user?.name ?? '',
          address: formData['Address'] as String? ?? user?.address ?? '',
          phoneNumber:
              formData['Phone Number'] as String? ?? user?.phoneNumber ?? '',
          email: user?.email ?? '',
          provider: user?.provider ?? '',
          profileImg: newProfileImgUrl ?? user?.profileImg ?? '',
          description: formData['Bio'] as String? ?? user?.description ?? '',
          validId: newValidIdUrl ?? user?.validId ?? '',
          role: user?.role ?? '',
          onlineStatus: user?.onlineStatus ?? false,
          createdAt: user?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await authController.updateUser(updatedUser);
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ProfileCompletion(profileCompletion: profileCompletion),
              ProfileForm(
                user: user ??
                    UserAccount(
                      id: '',
                      name: '',
                      address: '',
                      phoneNumber: '',
                      email: '',
                      provider: '',
                      profileImg: '',
                      description: '',
                      validId: '',
                      role: '',
                      onlineStatus: false,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                onSubmit: onSubmit,
                isLoading: isLoading,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
