import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/booking.dart';

class BookingView extends HookConsumerWidget with GlobalStyles {
  BookingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authController);

    final ValueNotifier<int?> numberOfChildren = useState<int?>(null);
    final ValueNotifier<DateTime?> startDate = useState<DateTime?>(null);
    final ValueNotifier<DateTime?> endDate = useState<DateTime?>(null);
    final ValueNotifier<TimeOfDay?> startTime = useState<TimeOfDay?>(null);
    final ValueNotifier<TimeOfDay?> endTime = useState<TimeOfDay?>(null);
    final ValueNotifier<bool> stayIn = useState<bool>(false);
    final ValueNotifier<String> details = useState<String>('');
    final ValueNotifier<String> selectedAddress = useState<String>('Home');

    return Scaffold(
      appBar: bookingAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildSectionTitle(
                  context, 'Children to take care of', Icons.child_care),
              const SizedBox(height: 8),
              buildChildrenSelector(
                context,
                numberOfChildren.value,
                (int value) => numberOfChildren.value = value,
              ),
              const SizedBox(height: 20),
              buildSectionTitle(context, 'Appointment Details', Icons.event),
              buildStayInToggle(stayIn.value, (bool value) {
                stayIn.value = value;
              }),
              buildBoardDateTimePicker(
                context: context,
                selectedDate: startDate.value,
                selectedTime: startTime.value,
                onDateSelected: (DateTime date) => startDate.value = date,
                onTimeSelected: (TimeOfDay time) => startTime.value = time,
                label: 'Start Time',
                icon: Icons.access_time,
              ),
              const SizedBox(height: 8),
              buildBoardDateTimePicker(
                context: context,
                selectedDate: endDate.value,
                selectedTime: endTime.value,
                onDateSelected: (DateTime date) => endDate.value = date,
                onTimeSelected: (TimeOfDay time) => endTime.value = time,
                label: 'End Time',
                icon: Icons.access_time_filled,
              ),
              const SizedBox(height: 20),
              buildDetailsSection(context, details.value, (String value) {
                details.value = value;
              }),
              const SizedBox(height: 20),
              buildAddressSection(selectedAddress.value, (String label) {
                selectedAddress.value = label;
              }),
              const SizedBox(height: 20),
              buildContinueButton(
                context: context,
                numberOfChildren: numberOfChildren.value,
                selectedDate: startDate.value,
                startTime: startTime.value,
                endTime: endTime.value,
                stayIn: stayIn.value,
                selectedAddress: selectedAddress.value,
                details: details.value,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
