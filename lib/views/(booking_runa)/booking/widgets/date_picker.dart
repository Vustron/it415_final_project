import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

Widget buildDatePicker(BuildContext context, DateTime? selectedDate,
    Future<void> Function(BuildContext) selectDate) {
  return Card(
    elevation: 2,
    child: ListTile(
      leading: const Icon(Icons.calendar_today,
          color: GlobalStyles.primaryButtonColor),
      title: Text(
        selectedDate == null
            ? 'Pick a date'
            : DateFormat('MMMM d, y').format(selectedDate),
        style: const TextStyle(
          color: Colors.black,
          fontFamily: nexaExtraLight,
        ),
      ),
      onTap: () => selectDate(context),
    ),
  );
}
