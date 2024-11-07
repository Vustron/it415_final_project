// widgets
import 'time_picker.dart';

// flutter
import 'package:flutter/material.dart';

Widget buildTimePickers(
    BuildContext context,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Future<void> Function(BuildContext) selectStartTime,
    Future<void> Function(BuildContext) selectEndTime) {
  return Row(
    children: <Widget>[
      Expanded(
        child: buildTimePicker(
          context,
          'Start',
          startTime,
          Icons.access_time,
          () => selectStartTime(context),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: buildTimePicker(
          context,
          'End',
          endTime,
          Icons.access_time_filled,
          () => selectEndTime(context),
        ),
      ),
    ],
  );
}
