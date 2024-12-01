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
      if (user.role == 'Babysitter')
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
      InputFieldConfig(
        type: 'select',
        label: 'Babysitting Experience',
        hintText: 'Select your experience level',
        prefixIcon: FluentIcons.timer_24_regular,
        options: const <String>[
          'Less than 1 year',
          '1-2 years',
          '2-5 years',
          '5-10 years',
          '10+ years',
        ],
        isRequired: true,
        value: user.babysittingExperience,
      ),
      InputFieldConfig(
        type: 'badges',
        label: 'Experience with Ages',
        hintText: 'Select age groups you have experience with',
        prefixIcon: FluentIcons.people_24_regular,
        options: const <String>[
          'Infants (0-1)',
          'Toddlers (1-3)',
          'Preschool (3-5)',
          'School Age (5-12)',
          'Teenagers (12+)',
        ],
        isRequired: true,
        isMultiSelect: true,
        value: user.experienceWithAges,
      ),
      InputFieldConfig(
        type: 'switch',
        label: 'Has Driving License',
        hintText: 'Do you have a valid driving license?',
        prefixIcon: FluentIcons.vehicle_car_24_regular,
        value: user.hasDrivingLicense,
      ),
      InputFieldConfig(
        type: 'switch',
        label: 'Has Car',
        hintText: 'Do you have your own car?',
        prefixIcon: FluentIcons.vehicle_car_24_regular,
        value: user.hasCar,
      ),
      InputFieldConfig(
        type: 'switch',
        label: 'Has Children',
        hintText: 'Do you have children of your own?',
        prefixIcon: FluentIcons.people_team_24_regular,
        value: user.hasChildren,
      ),
      InputFieldConfig(
        type: 'switch',
        label: 'Is Smoker',
        hintText: 'Are you a smoker?',
        prefixIcon: FluentIcons.heart_24_regular,
        value: user.isSmoker,
      ),
      InputFieldConfig(
        type: 'badges',
        label: 'Preferred Locations',
        hintText: 'Select areas you prefer to work in',
        prefixIcon: FluentIcons.location_24_regular,
        options: const <String>[
          'At the family',
          'At the babysitter’s',
        ],
        isMultiSelect: true,
        value: user.preferredBabysittingLocation,
      ),
      InputFieldConfig(
        type: 'badges',
        label: 'Languages',
        hintText: 'Select languages you speak',
        prefixIcon: FluentIcons.translate_24_regular,
        options: const <String>[
          'English',
          'Filipino',
          'Cebuano',
          'Hiligaynon',
          'Ilocano',
        ],
        isMultiSelect: true,
        value: user.languagesSpeak,
      ),
      InputFieldConfig(
        type: 'badges',
        label: 'Comfortable With',
        hintText: 'Select tasks you are comfortable with',
        prefixIcon: FluentIcons.checkmark_24_regular,
        options: const <String>[
          'Pets',
          'Cooking',
          'Chores',
          'Homework assistance',
        ],
        isMultiSelect: true,
        value: user.comfortableWith,
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
        if (user.role == null || user.role!.isEmpty) 'Role': user.role ?? '',
        'Profile Image': user.profileImg ?? '',
        'Valid ID': user.validId ?? '',
        'Valid ID Front': user.validIdFront ?? '',
        'Valid ID Back': user.validIdBack ?? '',
        if (user.role == 'Babysitter') ...<String, dynamic>{
          'Hourly Rate': user.hourlyRate,
          'Babysitting Experience': user.babysittingExperience,
          'Experience with Ages': user.experienceWithAges,
          'Has Driving License': user.hasDrivingLicense,
          'Has Car': user.hasCar,
          'Has Children': user.hasChildren,
          'Is Smoker': user.isSmoker,
          'Preferred Locations': user.preferredBabysittingLocation,
          'Languages': user.languagesSpeak,
          'Comfortable With': user.comfortableWith,
        },
      },
      onSubmit: onSubmit,
      isLoading: isLoading,
      userId: user.id,
    );
  }
}
