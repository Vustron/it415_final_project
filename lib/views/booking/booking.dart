import 'package:babysitterapp/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:babysitterapp/core/widgets/booking/appbar.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:intl/intl.dart';

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
              _buildSectionTitle('Children to take care of', Icons.child_care),
              const SizedBox(height: 8),
              _buildChildrenSelector(),
              const SizedBox(height: 20),
              _buildSectionTitle('Appointment Details', Icons.event),
              _buildStayInToggle(),
              _buildDatePicker(),
              const SizedBox(height: 20),
              _buildTimePickers(),
              const SizedBox(height: 20),
              _buildDetailsSection(),
              const SizedBox(height: 20),
              _buildAddressSection(),
              const SizedBox(height: 20),
              _buildContinueButton(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: <Widget>[
        Icon(icon, color: GlobalStyles.primaryButtonColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: GlobalStyles.primaryButtonColor,
                fontFamily: nexaExtraLight, // Use nexaExtraLight font
              ),
        ),
      ],
    );
  }

  Widget _buildChildrenSelector() {
    return InkWell(
      onTap: _showChildrenSelectionDialog,
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
                  fontFamily: nexaExtraLight, // Use nexaExtraLight font
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

  void _showChildrenSelectionDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select number of children'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(5, (int index) {
              return ListTile(
                leading: const Icon(Icons.child_care,
                    color: GlobalStyles.primaryButtonColor),
                title: Text('${index + 1}'),
                onTap: () {
                  setState(() {
                    numberOfChildren = index + 1;
                  });
                  Navigator.of(context).pop();
                },
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildStayInToggle() {
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
              onChanged: (bool value) {
                setState(() {
                  stayIn = value;
                });
              },
              activeColor: GlobalStyles.primaryButtonColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.calendar_today,
            color: GlobalStyles.primaryButtonColor),
        title: Text(
          selectedDate == null
              ? 'Pick a date'
              : DateFormat('MMMM d, y').format(selectedDate!),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: nexaExtraLight,
          ),
        ),
        onTap: _selectDate,
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: GlobalStyles.primaryButtonColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildTimePickers() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildTimePicker('Start', startTime, Icons.access_time,
              (TimeOfDay time) => setState(() => startTime = time)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimePicker('End', endTime, Icons.access_time_filled,
              (TimeOfDay time) => setState(() => endTime = time)),
        ),
      ],
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay? time, IconData icon,
      void Function(TimeOfDay) onTimeSelected) {
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
        onTap: () => _selectTime(onTimeSelected),
      ),
    );
  }

  Future<void> _selectTime(void Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: GlobalStyles.primaryButtonColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSectionTitle('Additional Details', Icons.note_add),
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
              onChanged: (String value) {
                setState(() {
                  details = value;
                });
              },
              style: const TextStyle(
                fontFamily: nexaExtraLight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
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
        _buildAddressOption('Home', 'Panabo city, Davao del Norte'),
        const SizedBox(height: 12),
        _buildAddressOption('Work', 'Panabo city, Davao del Norte'),
      ],
    );
  }

  Widget _buildAddressOption(String label, String address) {
    final bool isSelected = selectedAddress == label;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isSelected ? GlobalStyles.primaryButtonColor : Colors.grey[300]!,
          width: 2,
        ),
        color: isSelected
            ? GlobalStyles.primaryButtonColor.withOpacity(0.1)
            : Colors.white,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedAddress = label;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Radio<String>(
                value: label,
                groupValue: selectedAddress,
                onChanged: (String? value) {
                  setState(() {
                    selectedAddress = value!;
                  });
                },
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

  Widget _buildContinueButton() {
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
            fontFamily: nexaExtraLight, // Use nexaExtraLight font
          ),
        ),
      ),
    );
  }
}
