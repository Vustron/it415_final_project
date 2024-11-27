import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/constants.dart';

class TimeRangePicker extends StatelessWidget {
  const TimeRangePicker({
    super.key,
    required this.startFieldName,
    required this.endFieldName,
    this.initialStartTime,
    this.initialEndTime,
  });

  final String startFieldName;
  final String endFieldName;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;

  static const TimeOfDay _minTime = TimeOfDay(hour: 7, minute: 0);
  static const TimeOfDay _maxTime = TimeOfDay(hour: 20, minute: 0);

  bool _isTimeWithinBounds(TimeOfDay time) {
    final double timeValue = time.hour + time.minute / 60.0;
    final double minValue = _minTime.hour + _minTime.minute / 60.0;
    final double maxValue = _maxTime.hour + _maxTime.minute / 60.0;
    return timeValue >= minValue && timeValue <= maxValue;
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      isDense: true,
    );
  }

  String? _getErrorMessage(BuildContext context) {
    final FormBuilderState? formState = FormBuilder.of(context);
    if (formState == null) return null;

    final FormBuilderFieldState<FormBuilderField<DateTime>, DateTime>?
        startField = formState.fields[startFieldName]
            as FormBuilderFieldState<FormBuilderField<DateTime>, DateTime>?;
    final FormBuilderFieldState<FormBuilderField<DateTime>, DateTime>?
        endField = formState.fields[endFieldName]
            as FormBuilderFieldState<FormBuilderField<DateTime>, DateTime>?;

    if ((startField?.hasError ?? false) || (endField?.hasError ?? false)) {
      final List<String> errors = <String>[];

      if (startField?.hasError ?? false) {
        errors.add('Start time: ${startField?.errorText}');
      }
      if (endField?.hasError ?? false) {
        errors.add('End time: ${endField?.errorText}');
      }

      return errors.join(' • ');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ThemeData.light().colorScheme.copyWith(
                        primary: GlobalStyles.primaryButtonColor,
                        surface: Colors.white,
                        onSurface: Colors.black87,
                      ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: FormBuilderDateTimePicker(
                  name: startFieldName,
                  initialValue: initialStartTime != null
                      ? DateTime(2024, 1, 1, initialStartTime!.hour,
                          initialStartTime!.minute)
                      : null,
                  decoration: _buildDecoration('Start Time'),
                  inputType: InputType.time,
                  format: DateFormat('hh:mm a'),
                  validator: (DateTime? value) {
                    if (value == null) return 'Required';
                    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(value);
                    if (!_isTimeWithinBounds(timeOfDay)) {
                      return 'Must be between 7:00 AM and 8:00 PM';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ThemeData.light().colorScheme.copyWith(
                        primary: GlobalStyles.primaryButtonColor,
                        surface: Colors.white,
                        onSurface: Colors.black87,
                      ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: FormBuilderDateTimePicker(
                  name: endFieldName,
                  initialValue: initialEndTime != null
                      ? DateTime(2024, 1, 1, initialEndTime!.hour,
                          initialEndTime!.minute)
                      : null,
                  decoration: _buildDecoration('End Time'),
                  inputType: InputType.time,
                  format: DateFormat('hh:mm a'),
                  validator: (DateTime? value) {
                    if (value == null) return 'Required';
                    final TimeOfDay timeOfDay = TimeOfDay.fromDateTime(value);
                    if (!_isTimeWithinBounds(timeOfDay)) {
                      return 'Must be between 7:00 AM and 8:00 PM';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        FormBuilderField<String>(
          name: '${startFieldName}_${endFieldName}_error',
          builder: (FormFieldState<String> field) {
            final String? errorText = _getErrorMessage(context);
            return errorText != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
