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
        prefixIcon: FluentIcons.image_20_regular,
        value: user.profileImg,
      ),
      InputFieldConfig(
        label: 'Name',
        type: 'text',
        hintText: 'Enter your name here',
        prefixIcon: FluentIcons.person_20_regular,
        value: user.name ?? '',
      ),
      InputFieldConfig(
        label: 'Gender',
        type: 'select',
        hintText: 'Select your gender',
        prefixIcon: FluentIcons.person_20_regular,
        options: const <String>[
          'Male',
          'Female',
          'Prefer not to say',
        ],
        value: user.gender,
      ),
      InputFieldConfig(
        label: 'Address',
        type: 'address',
        hintText: 'Enter your address here',
        prefixIcon: FluentIcons.location_20_regular,
        value: user.address ?? '',
      ),
      InputFieldConfig(
        label: 'Address Latitude',
        type: 'readonly',
        hintText: 'Latitude',
        prefixIcon: FluentIcons.location_20_regular,
        value: user.addressLatitude,
      ),
      InputFieldConfig(
        label: 'Address Longitude',
        type: 'readonly',
        hintText: 'Longitude',
        prefixIcon: FluentIcons.location_20_regular,
        value: user.addressLongitude,
      ),
      InputFieldConfig(
        label: 'Bio',
        type: 'text',
        hintText: 'Enter your bio here',
        prefixIcon: FluentIcons.text_description_20_regular,
        value: user.description ?? '',
      ),
      InputFieldConfig(
        label: 'Phone Number',
        type: 'phone',
        hintText: 'Enter your phone number here',
        prefixIcon: FluentIcons.phone_20_regular,
        isRequired: true,
        value: user.phoneNumber ?? '',
      ),
      if (user.role == null || user.role!.isEmpty)
        InputFieldConfig(
          label: 'Role',
          type: 'select',
          hintText: 'Select your role',
          prefixIcon: FluentIcons.person_tag_20_regular,
          options: const <String>[
            'Parent',
            'Babysitter',
          ],
          isRequired: true,
          value: user.role,
        ),
      InputFieldConfig(
        label: 'Birth Date',
        hintText: 'Select your birth date',
        keyboardType: TextInputType.datetime,
        prefixIcon: FluentIcons.calendar_20_regular,
        type: 'date',
        isRequired: true,
        value: user.birthDate,
      ),
      InputFieldConfig(
        type: 'number',
        label: 'Hourly Rate',
        hintText: 'Enter your hourly rate',
        prefixIcon: FluentIcons.money_24_regular,
        isRequired: true,
        min: 0,
        max: 10000,
        isCurrency: true,
        value: user.hourlyRate,
      ),
    ];

    return DynamicForm(
      fields: fields,
      initialData: <String, dynamic>{
        'Name': user.name ?? '',
        'Address': user.address ?? '',
        'Address Latitude': user.addressLatitude ?? '',
        'Address Longitude': user.addressLongitude ?? '',
        'Phone Number': user.phoneNumber ?? '',
        'Bio': user.description ?? '',
        'Valid ID Type': user.validId ?? '',
        'Gender': user.gender ?? '',
        'Birth Date': user.birthDate,
        'Hourly Rate': user.hourlyRate,
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
