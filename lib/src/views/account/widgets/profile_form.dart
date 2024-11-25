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
        type: 'address',
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
        type: 'phone',
        hintText: 'Enter your phone number here',
        value: user.phoneNumber ?? '',
        prefixIcon: FluentIcons.phone_20_regular,
        isRequired: true,
      ),
      if (user.role == null || user.role!.isEmpty)
        InputFieldConfig(
          label: 'Role',
          type: 'select',
          hintText: 'Select your role',
          value: user.role,
          prefixIcon: FluentIcons.person_tag_20_regular,
          options: const <String>[
            'Parent',
            'Babysitter',
          ],
          isRequired: true,
        ),
      const InputFieldConfig(
        label: 'Birth Date',
        hintText: 'Select your birth date',
        keyboardType: TextInputType.datetime,
        prefixIcon: FluentIcons.calendar_20_regular,
        type: 'date',
        isRequired: true,
      ),
    ];

    return DynamicForm(
      fields: fields,
      initialData: <String, dynamic>{
        'Name': user.name ?? '',
        'Address': user.address ?? '',
        'Phone Number': user.phoneNumber ?? '',
        'Bio': user.description ?? '',
        'Valid ID Type': user.validId ?? '',
        'Gender': user.gender ?? '',
        'Birth Date': user.birthDate,
        if (user.role == null || user.role!.isEmpty) 'Role': user.role ?? '',
        'Profile Image': user.profileImg ?? '',
        'Valid ID': user.validId ?? '',
        'Valid ID Front': user.validIdFront ?? '',
        'Valid ID Back': user.validIdBack ?? '',
      },
      onSubmit: onSubmit,
      isLoading: isLoading,
      userId: user.id,
    );
  }
}
