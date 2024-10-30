// core
import 'package:babysitterapp/views/booking/widgets/appbar.dart';

// widgets
import 'widgets/children_selector.dart';
import 'widgets/continue_btn.dart';
import 'widgets/section_title.dart';
import 'widgets/stayin_toggle.dart';
import 'widgets/time_pickers.dart';
import 'widgets/date_picker.dart';
import 'widgets/address.dart';
import 'widgets/details.dart';

// flutter
import 'package:flutter/material.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
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
              buildContinueButton(
                context: context,
                numberOfChildren: numberOfChildren,
                selectedDate: selectedDate,
                startTime: startTime,
                endTime: endTime,
                stayIn: stayIn,
                selectedAddress: selectedAddress,
                details: details,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
