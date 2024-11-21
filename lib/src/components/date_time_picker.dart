import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/constants.dart';

String _format12HourTime(TimeOfDay? time, BuildContext context) {
  if (time == null) {
    return '';
  }
  final DateTime now = DateTime.now();
  final DateTime dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  return DateFormat('hh:mm a').format(dateTime); // 'a' adds AM/PM indicator
}

Widget buildBoardDateTimePicker({
  required BuildContext context,
  required DateTime? selectedDate,
  required TimeOfDay? selectedTime,
  required void Function(DateTime) onDateSelected,
  required void Function(TimeOfDay) onTimeSelected,
  required String label,
  required IconData icon,
}) {
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: Icon(icon, color: GlobalStyles.primaryButtonColor),
      title: Text(
        selectedDate == null
            ? label
            : '${DateFormat('dd/MM/yyyy').format(selectedDate)} ${_format12HourTime(selectedTime, context)}',
        style: const TextStyle(
          fontFamily: nexaExtraLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      onTap: () async {
        try {
          final DateTime? result = await showBoardDateTimePicker(
            context: context,
            pickerType: DateTimePickerType.datetime,
            options: BoardDateTimeOptions(
              backgroundColor: Colors.white,
              activeColor: GlobalStyles.primaryButtonColor,
              activeTextColor: Colors.white,
              customOptions: BoardPickerCustomOptions(
                hours: List<int>.generate(24, (int i) => i + 1),
              ),
              pickerSubTitles: const BoardDateTimeItemTitles(
                hour: 'Hour',
                minute: 'Minute',
              ),
            ),
          );

          if (result != null) {
            onDateSelected(result);
            final TimeOfDay newTime =
                TimeOfDay(hour: result.hour, minute: result.minute);
            onTimeSelected(newTime);
          }
        } catch (e) {
          debugPrint('Error showing date time picker: $e');
        }
      },
    ),
  );
}
