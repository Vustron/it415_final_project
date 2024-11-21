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
    final List<dynamic>? profileImageValue = user.profileImg != null
        ? <dynamic>[NetworkImage(user.profileImg!)]
        : null;

    final List<dynamic>? validIdValue =
        user.validId != null ? <dynamic>[NetworkImage(user.validId!)] : null;

    final List<InputFieldConfig> fields = <InputFieldConfig>[
      InputFieldConfig(
        label: 'Profile Image',
        type: 'image',
        hintText: 'Upload your profile image',
        value: profileImageValue,
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
        label: 'Valid ID',
        type: 'image',
        hintText: 'Upload your valid ID',
        value: validIdValue,
        prefixIcon: FluentIcons.document_20_regular,
      ),
    ];

    return DynamicForm(
      fields: fields,
      initialData: <String, dynamic>{
        'Profile Image': profileImageValue,
        'Name': user.name,
        'Address': user.address,
        'Bio': user.description,
        'Phone Number': user.phoneNumber,
        'Valid ID': validIdValue,
      },
      onSubmit: onSubmit,
      isLoading: isLoading,
    );
  }
}
