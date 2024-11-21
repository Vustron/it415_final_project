import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/constants.dart';

bool isFormValid({
  required int? numberOfChildren,
  required DateTime? selectedDate,
  required TimeOfDay? startTime,
  required TimeOfDay? endTime,
  required String selectedAddress,
}) {
  return numberOfChildren != null &&
      selectedDate != null &&
      startTime != null &&
      endTime != null &&
      selectedAddress.isNotEmpty;
}

void onContinuePressed({
  required BuildContext context,
  required int? numberOfChildren,
  required DateTime? selectedDate,
  required TimeOfDay? startTime,
  required TimeOfDay? endTime,
  required bool stayIn,
  required String selectedAddress,
  required String details,
}) {
  if (isFormValid(
    numberOfChildren: numberOfChildren,
    selectedDate: selectedDate,
    startTime: startTime,
    endTime: endTime,
    selectedAddress: selectedAddress,
  )) {
    final String bookingDetails = 'Booking details: '
        '\nChildren: $numberOfChildren'
        '\nDate: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
        '\nTime: ${startTime?.format(context)} - ${endTime?.format(context)}'
        '\nStay in: $stayIn'
        '\nAddress: $selectedAddress'
        '\nDetails: $details';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(bookingDetails),
        backgroundColor: Colors.green,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all required fields'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Widget buildContinueButton({
  required BuildContext context,
  required int? numberOfChildren,
  required DateTime? selectedDate,
  required TimeOfDay? startTime,
  required TimeOfDay? endTime,
  required bool stayIn,
  required String selectedAddress,
  required String details,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        onContinuePressed(
          context: context,
          numberOfChildren: numberOfChildren,
          selectedDate: selectedDate,
          startTime: startTime,
          endTime: endTime,
          stayIn: stayIn,
          selectedAddress: selectedAddress,
          details: details,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalStyles.primaryButtonColor,
        foregroundColor: GlobalStyles.secondaryButtonColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: const Icon(Icons.check),
      label: const Text(
        'Continue Booking',
        style: TextStyle(
          fontFamily: nexaExtraLight,
        ),
      ),
    ),
  );
}
