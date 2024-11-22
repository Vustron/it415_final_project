import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/models.dart';

class ProfileForm extends HookWidget {
  const ProfileForm({
    super.key,
    required this.user,
    required this.onSubmit,
    required this.isLoading,
  });

  final UserAccount user;
  final void Function(Map<String, dynamic>) onSubmit;
  final ValueNotifier<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    final List<InputFieldConfig> fields = <InputFieldConfig>[
      InputFieldConfig(
        label: 'Profile Image',
        type: 'image',
        hintText: 'Upload your profile image',
        value: user.profileImg,
        prefixIcon: FluentIcons.image_20_regular,
      ),
      InputFieldConfig(
        label: 'Name',
        type: 'text',
        hintText: 'Enter your name here',
        value: user.name ?? '',
        prefixIcon: FluentIcons.person_20_regular,
      ),
      InputFieldConfig(
        label: 'Gender',
        type: 'select',
        hintText: 'Select your gender',
        value: user.gender,
        prefixIcon: FluentIcons.person_20_regular,
        options: const <String>[
          'Male',
          'Female',
          'Prefer not to say',
        ],
      ),
      InputFieldConfig(
        label: 'Address',
        type: 'text',
        hintText: 'Enter your address here',
        value: user.address ?? '',
        prefixIcon: FluentIcons.location_20_regular,
      ),
      InputFieldConfig(
        label: 'Bio',
        type: 'text',
        hintText: 'Enter your bio here',
        value: user.description ?? '',
        prefixIcon: FluentIcons.text_description_20_regular,
      ),
      InputFieldConfig(
        label: 'Phone Number',
        type: 'text',
        hintText: 'Enter your phone number here',
        value: user.phoneNumber ?? '',
        prefixIcon: FluentIcons.phone_20_regular,
      ),
      InputFieldConfig(
        label: 'Valid ID Type',
        type: 'select',
        hintText: 'Select your valid ID type',
        value: user.validId,
        prefixIcon: FluentIcons.document_20_regular,
        options: const <String>[
          'National ID',
          "Driver's License",
          'Passport',
          'SSS ID',
          'PhilHealth ID',
          'Postal ID',
          "Voter's ID",
        ],
      ),
    ];

    return DynamicForm(
      fields: fields,
      initialData: <String, dynamic>{
        'Profile Image': user.profileImg,
        'Name': user.name,
        'Gender': user.gender,
        'Address': user.address,
        'Bio': user.description,
        'Phone Number': user.phoneNumber,
        'Valid ID Type': user.validId,
      },
      onSubmit: onSubmit,
      isLoading: isLoading,
      userId: user.id,
    );
  }
}
