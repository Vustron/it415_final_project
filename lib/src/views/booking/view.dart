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
        prefixIcon: Icons.child_care,
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
        prefixIcon: Icons.home,
        value: false,
      ),
      const InputFieldConfig(
        type: 'date',
        label: 'Start Date',
        hintText: 'Select start date',
        prefixIcon: Icons.calendar_today,
        isRequired: true,
      ),
      const InputFieldConfig(
        type: 'date',
        label: 'End Date',
        hintText: 'Select end date',
        prefixIcon: Icons.calendar_today,
        isRequired: true,
      ),
      const InputFieldConfig(
        type: 'address',
        label: 'Address',
        hintText: 'Select your address',
        prefixIcon: Icons.location_on,
        isRequired: true,
      ),
      InputFieldConfig(
        type: 'time',
        label: 'Start Time',
        hintText: 'Select start time',
        prefixIcon: Icons.access_time,
        isRequired: true,
        value: startTime,
        use24HourFormat: false,
      ),
      InputFieldConfig(
        type: 'time',
        label: 'End Time',
        hintText: 'Select end time',
        prefixIcon: Icons.access_time,
        isRequired: true,
        value: endTime,
        use24HourFormat: false,
      ),
      const InputFieldConfig(
        type: 'text',
        label: 'Additional Details',
        hintText: 'Any special requirements or notes?',
        prefixIcon: Icons.note_add,
        isRequired: false,
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
        Start Time: ${formData['Start Time']?.format(context)}
        End Time: ${formData['End Time']?.format(context)}
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
