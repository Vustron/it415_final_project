import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class BookingView extends HookConsumerWidget {
  const BookingView({super.key});

  List<InputFieldConfig> _buildFormFields(
      TimeOfDay? startTime, TimeOfDay? endTime) {
    return <InputFieldConfig>[
      const InputFieldConfig(
        type: 'slider',
        label: 'Number of Children',
        hintText: 'Choose the number of children',
        prefixIcon: FluentIcons.people_24_regular,
        isRequired: true,
        min: 1,
        max: 12,
        divisions: 11,
        value: 1,
        isInteger: true,
      ),
      const InputFieldConfig(
        type: 'switch',
        label: 'Stay In',
        hintText: 'Toggle if babysitter should stay in',
        prefixIcon: FluentIcons.home_24_regular,
        value: false,
      ),
      const InputFieldConfig(
        type: 'date',
        label: 'Start Date',
        hintText: 'Select start date',
        prefixIcon: FluentIcons.calendar_24_regular,
        isRequired: true,
      ),
      const InputFieldConfig(
        type: 'date',
        label: 'End Date',
        hintText: 'Select end date',
        prefixIcon: FluentIcons.calendar_24_regular,
        isRequired: true,
      ),
      const InputFieldConfig(
        type: 'address',
        label: 'Address',
        hintText: 'Select your address',
        prefixIcon: FluentIcons.location_24_regular,
        isRequired: true,
      ),
      const InputFieldConfig(
        label: 'Working Hours',
        type: 'timeRange',
        isRequired: true,
        prefixIcon: FluentIcons.clock_24_regular,
        hintText: 'Select working hours range',
      ),
      const InputFieldConfig(
        type: 'textarea',
        label: 'Additional details',
        hintText: 'Enter a detailed description...',
        prefixIcon: FluentIcons.text_description_24_regular,
        isRequired: true,
        minLines: 3,
        maxLines: 5,
        maxLength: 500,
        minLength: 1,
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<TimeOfDay?> startTime = useState<TimeOfDay?>(null);
    final ValueNotifier<TimeOfDay?> endTime = useState<TimeOfDay?>(null);

    void onSubmit(Map<String, dynamic> formData) {
      final String bookingDetails = '''
        Booking details:
        Children: ${formData['Number of Children']}
        Stay In: ${formData['Stay In']}
        Start Time: ${(formData['Start Time'] as TimeOfDay?)?.format(context)}
        End Time: ${(formData['End Time'] as TimeOfDay?)?.format(context)}
        Address: ${formData['Address']}
        Details: ${formData['Additional Details']}
      ''';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(bookingDetails),
          backgroundColor: Colors.green,
        ),
      );
    }

    return Scaffold(
      appBar: bookingAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DynamicForm(
                fields: _buildFormFields(startTime.value, endTime.value),
                onSubmit: onSubmit,
                isLoading: isLoading,
              ),
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
