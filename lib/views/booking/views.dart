// third party
import 'package:intl/intl.dart';

// core
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget buildSectionTitle(BuildContext context, String title, IconData icon) {
  return Row(
    children: <Widget>[
      Icon(icon, color: GlobalStyles.primaryButtonColor),
      const SizedBox(width: 8),
      Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: GlobalStyles.primaryButtonColor,
              fontFamily: nexaExtraLight,
            ),
      ),
    ],
  );
}

Widget buildChildrenSelector(BuildContext context, int? numberOfChildren,
    void Function(BuildContext) showChildrenSelectionDialog) {
  return InkWell(
    onTap: () => showChildrenSelectionDialog(context),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: GlobalStyles.primaryButtonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GlobalStyles.primaryButtonColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              numberOfChildren == null
                  ? 'Choose the number of children'
                  : '$numberOfChildren ${numberOfChildren == 1 ? 'child' : 'children'}',
              style: const TextStyle(
                color: GlobalStyles.primaryButtonColor,
                fontFamily: nexaExtraLight,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_drop_down,
              color: GlobalStyles.primaryButtonColor),
        ],
      ),
    ),
  );
}

Widget buildStayInToggle(bool stayIn, void Function(bool) onChanged) {
  return Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.home, color: GlobalStyles.primaryButtonColor),
              SizedBox(width: 8),
              Text('Stay In', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Switch(
            value: stayIn,
            onChanged: onChanged,
            activeColor: GlobalStyles.primaryButtonColor,
          ),
        ],
      ),
    ),
  );
}

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

Widget buildDetailsSection(
    BuildContext context, String details, void Function(String) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      buildSectionTitle(context, 'Additional Details', Icons.note_add),
      const SizedBox(height: 8),
      Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Any special requirements or notes?',
              border: InputBorder.none,
            ),
            maxLines: 3,
            onChanged: onChanged,
            style: const TextStyle(
              fontFamily: nexaExtraLight,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildAddressSection(
    String selectedAddress, void Function(String) onAddressSelected) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Row(
        children: <Widget>[
          Icon(Icons.location_on, color: GlobalStyles.primaryButtonColor),
          SizedBox(width: 8),
          Text(
            'Select Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: GlobalStyles.primaryButtonColor,
              fontFamily: nexaExtraLight,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      buildAddressOption('Home', 'Panabo city, Davao del Norte',
          selectedAddress, onAddressSelected),
      const SizedBox(height: 12),
      buildAddressOption('Work', 'Panabo city, Davao del Norte',
          selectedAddress, onAddressSelected),
    ],
  );
}

Widget buildAddressOption(String label, String address, String selectedAddress,
    void Function(String) onAddressSelected) {
  final bool isSelected = selectedAddress == label;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? GlobalStyles.primaryButtonColor : Colors.grey[300]!,
        width: 2,
      ),
      color: isSelected
          ? GlobalStyles.primaryButtonColor.withOpacity(0.1)
          : Colors.white,
    ),
    child: InkWell(
      onTap: () => onAddressSelected(label),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Radio<String>(
              value: label,
              groupValue: selectedAddress,
              onChanged: (String? value) => onAddressSelected(value!),
              activeColor: GlobalStyles.primaryButtonColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: nexaExtraLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontFamily: nexaExtraLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Implement see on map functionality
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: GlobalStyles.primaryButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.map),
              label: const Text('Map'),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildContinueButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () {
        // Implement booking continuation
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
