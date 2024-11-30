import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class BookingView extends HookConsumerWidget {
  const BookingView({super.key, this.babysitterId});
  final String? babysitterId;

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
        label: 'Working Date',
        hintText: 'Select start date',
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
        label: 'Address Latitude',
        type: 'readonly',
        hintText: 'Latitude',
        value: '',
        prefixIcon: FluentIcons.location_20_regular,
      ),
      const InputFieldConfig(
        label: 'Address Longitude',
        type: 'readonly',
        hintText: 'Longitude',
        value: '',
        prefixIcon: FluentIcons.location_20_regular,
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
    final Toast toast = ref.watch(toastService);
    final UserAccount? currentUser = ref.watch(authControllerService).user;
    final LoggerService logger = ref.watch(loggerService);

    Future<void> onSubmit(Map<String, dynamic> formData) async {
      if (currentUser == null) {
        toast.show(
          context: context,
          title: 'Error',
          message: 'You must be logged in to book a babysitter',
          type: 'error',
        );
        return;
      }

      isLoading.value = true;

      try {
        String address;
        String latitude;
        String longitude;

        final DateTime? startDateTime =
            formData['Working Hours_start'] as DateTime?;
        final DateTime? endDateTime =
            formData['Working Hours_end'] as DateTime?;

        final String? startTimeStr = startDateTime != null
            ? TimeOfDay.fromDateTime(startDateTime).format(context)
            : null;
        final String? endTimeStr = endDateTime != null
            ? TimeOfDay.fromDateTime(endDateTime).format(context)
            : null;

        final dynamic addressData = formData['Address'];
        final dynamic latitudeData = formData['Address Latitude'];
        final dynamic longitudeData = formData['Address Longitude'];

        if (addressData != null) {
          address = addressData.toString();
          latitude = (latitudeData ?? '0.0').toString();
          longitude = (longitudeData ?? '0.0').toString();
        } else {
          address = 'No address provided';
          latitude = '0.0';
          longitude = '0.0';
        }

        final Map<String, Object?> bookingData = <String, Object?>{
          'parentId': currentUser.id,
          'babysitterId': babysitterId,
          'Number of Children':
              (formData['Number of Children'] as double).toInt(),
          'Stay In': formData['Stay In'] as bool,
          'Working Date': formData['Working Date'] as DateTime,
          'Address': address,
          'AddressLatitude': latitude,
          'AddressLongitude': longitude,
          'Start Time': startTimeStr,
          'End Time': endTimeStr,
          'Additional details': formData['Additional details'] as String,
        };

        // logger.debug('Creating booking: $bookingData');

        await ref.read(bookingControllerService.notifier).createBooking(
              currentUser.id!,
              babysitterId!,
              bookingData,
            );

        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Success',
            message: 'Booking created successfully',
            type: 'success',
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        logger.error('Error creating booking: $e');
        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Error',
            message: 'Failed to create booking',
            type: 'error',
          );
        }
      } finally {
        isLoading.value = false;
      }
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
