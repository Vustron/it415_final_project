import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/authentication_controller.dart';
import 'package:babysitterapp/core/helper/check_user.dart';
import 'package:babysitterapp/core/constants/styles.dart';

import 'widgets/children_selector.dart';
import 'widgets/continue_btn.dart';
import 'widgets/section_title.dart';
import 'widgets/stayin_toggle.dart';
import 'widgets/time_pickers.dart';
import 'widgets/date_picker.dart';
import 'widgets/address.dart';
import 'widgets/details.dart';
import 'widgets/appbar.dart';

class BookingView extends HookConsumerWidget with GlobalStyles {
  BookingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authController);

    useEffect(() {
      checkUserAndRedirect(context, ref);
      return null;
    }, <Object?>[]);

    final ValueNotifier<int?> numberOfChildren = useState<int?>(null);
    final ValueNotifier<DateTime?> selectedDate = useState<DateTime?>(null);
    final ValueNotifier<TimeOfDay?> startTime = useState<TimeOfDay?>(null);
    final ValueNotifier<TimeOfDay?> endTime = useState<TimeOfDay?>(null);
    final ValueNotifier<bool> stayIn = useState<bool>(false);
    final ValueNotifier<String> details = useState<String>('');
    final ValueNotifier<String> selectedAddress = useState<String>('Home');

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
        numberOfChildren.value = result;
      }
    }

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (picked != null && picked != selectedDate.value) {
        selectedDate.value = picked;
      }
    }

    Future<void> selectStartTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: startTime.value ?? TimeOfDay.now(),
      );

      if (picked != null) {
        startTime.value = picked;
      }
    }

    Future<void> selectEndTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: endTime.value ?? TimeOfDay.now(),
      );

      if (picked != null) {
        endTime.value = picked;
      }
    }

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
                  context, numberOfChildren.value, showChildrenSelectionDialog),
              const SizedBox(height: 20),
              buildSectionTitle(context, 'Appointment Details', Icons.event),
              buildStayInToggle(stayIn.value, (bool value) {
                stayIn.value = value;
              }),
              buildDatePicker(context, selectedDate.value, selectDate),
              const SizedBox(height: 20),
              buildTimePickers(
                context,
                startTime.value,
                endTime.value,
                selectStartTime,
                selectEndTime,
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
                selectedDate: selectedDate.value,
                startTime: startTime.value,
                endTime: endTime.value,
                stayIn: stayIn.value,
                selectedAddress: selectedAddress.value,
                details: details.value,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
