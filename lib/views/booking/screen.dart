// core
import 'package:babysitterapp/core/widgets/booking/appbar.dart';
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// third party
import 'package:intl/intl.dart';

// flutter
import 'package:flutter/material.dart';

import 'views.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int? numberOfChildren;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool stayIn = false;
  String details = '';
  String selectedAddress = 'Home';

  Future<void> showChildrenSelectionDialog(BuildContext context) async {
    final int? result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Number of Children'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(
              5,
              (int index) => ListTile(
                title:
                    Text('${index + 1} ${index == 0 ? 'child' : 'children'}'),
                onTap: () => Navigator.of(context).pop(index + 1),
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        numberOfChildren = result;
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    return;
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  bool isFormValid() {
    return numberOfChildren != null &&
        selectedDate != null &&
        startTime != null &&
        endTime != null &&
        selectedAddress.isNotEmpty;
  }

  void onContinuePressed() {
    if (isFormValid()) {
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

  @override
  Widget build(BuildContext context) {
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
                  context, numberOfChildren, showChildrenSelectionDialog),
              const SizedBox(height: 20),
              buildSectionTitle(context, 'Appointment Details', Icons.event),
              buildStayInToggle(stayIn, (bool value) {
                setState(() {
                  stayIn = value;
                });
              }),
              buildDatePicker(context, selectedDate, selectDate),
              const SizedBox(height: 20),
              buildTimePickers(
                context,
                startTime,
                endTime,
                selectStartTime,
                selectEndTime,
              ),
              const SizedBox(height: 20),
              buildDetailsSection(context, details, (String value) {
                setState(() {
                  details = value;
                });
              }),
              const SizedBox(height: 20),
              buildAddressSection(selectedAddress, (String label) {
                setState(() {
                  selectedAddress = label;
                });
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onContinuePressed,
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
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
