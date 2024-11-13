import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/models/user_account.dart';
import 'package:babysitterapp/models/inputfield.dart';

class EditProfile extends HookConsumerWidget with GlobalStyles {
  EditProfile({super.key, required this.user});

  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);

    // Fields definition
    final List<InputFieldConfig> fields = <InputFieldConfig>[
      InputFieldConfig(
        label: 'Profile Image',
        type: 'file',
        hintText: 'Upload your profile image',
        value: user.profileImg,
      ),
      InputFieldConfig(
        label: 'Name',
        type: 'text',
        hintText: 'Enter your name here',
        value: user.name,
      ),
      InputFieldConfig(
        label: 'Address',
        type: 'text',
        hintText: 'Enter your address here',
        value: user.address,
      ),
      InputFieldConfig(
        label: 'Bio',
        type: 'text',
        hintText: 'Enter your bio here',
        value: user.description,
      ),
      InputFieldConfig(
        label: 'Phone Number',
        type: 'text',
        hintText: 'Enter your phone number here',
        value: user.phoneNumber,
      ),
      InputFieldConfig(
        label: 'Valid ID',
        type: 'file',
        hintText: 'Upload your valid ID',
        value: user.validId,
      ),
    ];

    double calculateProfileCompletion(UserAccount user) {
      final List<String?> userFields = <String?>[
        user.profileImg,
        user.name,
        user.address,
        user.description,
        user.phoneNumber,
        user.validId,
      ];

      final int completedFields = userFields.where((String? field) => field?.isNotEmpty ?? false).length;
      final int totalFields = userFields.length;

      return (completedFields / totalFields) * 100;
    }

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 18),
                  const Text(
                    'Edit Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),


                  const SizedBox(height: 8),

                  LinearProgressIndicator(
                    value: profileCompletion / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Profile Completion: ${profileCompletion.toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                ],
              ),

              DynamicForm(
                fields: fields,
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
