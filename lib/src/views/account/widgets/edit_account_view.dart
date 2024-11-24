import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class EditAccountView extends HookConsumerWidget with GlobalStyles {
  EditAccountView({super.key, required this.user});
  final UserAccount? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final double profileCompletion = calculateProfileCompletion(user!);
    final AuthController authController =
        ref.watch(authControllerProvider.notifier);
    final Toast toastRepository = ref.watch(toastProvider);

    Future<void> onSubmit(Map<String, dynamic> formData) async {
      try {
        isLoading.value = true;
        String? newProfileImgUrl;

        if (formData['Profile Image'] != null) {
          final dynamic imageData = formData['Profile Image'];
          if (imageData is String) {
            newProfileImgUrl = imageData;
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
          gender: formData['Gender'] as String? ?? user?.gender ?? '',
          birthDate: formData['Birth Date'] as DateTime? ?? user?.birthDate,
          role: user?.provider == 'google'
              ? formData['Role'] as String? ?? user?.role ?? ''
              : user?.role ?? '',
          onlineStatus: user?.onlineStatus ?? false,
          emailVerified: user?.emailVerified,
          validIdVerified: user?.validIdVerified,
          validIdFront: user?.validIdFront ?? '',
          validIdBack: user?.validIdBack ?? '',
          createdAt: user?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await authController.updateUser(updatedUser);

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
              message: 'Profile updated successfully',
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, Routes.dashboard);
            });
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
                      gender: '',
                      role: '',
                      onlineStatus: false,
                      emailVerified: null,
                      validIdVerified: null,
                      validIdFront: '',
                      validIdBack: '',
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
