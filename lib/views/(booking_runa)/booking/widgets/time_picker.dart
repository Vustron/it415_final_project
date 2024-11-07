// core
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget buildTimePicker(BuildContext context, String label, TimeOfDay? time,
    IconData icon, VoidCallback onTimeSelected) {
  return Card(
    elevation: 2,
    child: ListTile(
      leading: Icon(icon, color: GlobalStyles.primaryButtonColor),
      title: Text(
        time == null ? label : time.format(context),
        style: const TextStyle(
          color: Colors.black,
          fontFamily: nexaExtraLight,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: onTimeSelected,
    ),
  );
}
