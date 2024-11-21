import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class EditProfileView extends HookConsumerWidget with GlobalStyles {
  EditProfileView({super.key, required this.user});
  final UserAccount? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final double profileCompletion = calculateProfileCompletion(user!);
    // ignore: unused_local_variable
    final AuthController authController =
        ref.watch(authControllerProvider.notifier);

    Future<void> onSubmit(Map<String, dynamic> formData) async {
      isLoading.value = true;

      try {
        String? profileImgUrl;
        // if (formData['Profile Image']?.isNotEmpty ?? false) {
        //   profileImgUrl = await authController.uploadFile(
        //     'profile_images/${user.id}',
        //     formData['Profile Image'],
        //   );
        // }

        String? validIdUrl;
        // if (formData['Valid ID']?.isNotEmpty ?? false) {
        //   validIdUrl = await authController.uploadFile(
        //     'valid_ids/${user.id}',
        //     formData['Valid ID'],
        //   );
        // }

        // ignore: unused_local_variable
        final UserAccount updatedUser = UserAccount(
          id: user?.id ?? '',
          name: formData['Name'] as String? ?? user?.name ?? '',
          address: formData['Address'] as String? ?? user?.address ?? '',
          phoneNumber:
              formData['Phone Number'] as String? ?? user?.phoneNumber ?? '',
          email: user?.email ?? '',
          provider: user?.provider ?? '',
          profileImg: profileImgUrl ?? user?.profileImg ?? '',
          description: formData['Bio'] as String? ?? user?.description ?? '',
          validId: validIdUrl ?? user?.validId ?? '',
          role: user?.role ?? '',
          onlineStatus: user?.onlineStatus ?? false,
          createdAt: user?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // await authController.updateAccount(updatedUser);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile: $e'),
              backgroundColor: Colors.red,
            ),
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
