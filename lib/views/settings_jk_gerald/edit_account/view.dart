import 'package:babysitterapp/views/settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/models/models.dart';

class EditProfile extends HookConsumerWidget with GlobalStyles {
  EditProfile({super.key, required this.user});

  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);

    final double profileCompletion = calculateProfileCompletion(user);

    Future<void> onSubmit(Map<String, String> formData) async {
      isLoading.value = true;

      try {
        String? profileImgUrl;
        if (formData['Profile Image']?.isNotEmpty ?? false) {
          profileImgUrl = await ref.read(authController.notifier).uploadFile(
                'profile_images/${user.id}',
                formData['Profile Image'],
              );
        }

        String? validIdUrl;
        if (formData['Valid ID']?.isNotEmpty ?? false) {
          validIdUrl = await ref.read(authController.notifier).uploadFile(
                'valid_ids/${user.id}',
                formData['Valid ID'],
              );
        }

        final UserAccount updatedUser = UserAccount(
          id: user.id,
          name: formData['Name'] ?? user.name,
          address: formData['Address'] ?? user.address,
          phoneNumber: formData['Phone Number'] ?? user.phoneNumber,
          email: user.email,
          provider: user.provider,
          profileImg: profileImgUrl ?? user.profileImg,
          description: formData['Bio'] ?? user.description,
          validId: validIdUrl ?? user.validId,
          role: user.role,
          onlineStatus: user.onlineStatus,
          createdAt: user.createdAt,
          updatedAt: DateTime.now(),
        );

        await ref.read(authController.notifier).updateAccount(updatedUser);

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
                user: user,
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
