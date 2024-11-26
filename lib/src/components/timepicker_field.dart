import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/constants.dart';

class TimeRange {
  const TimeRange({
    this.startTime,
    this.endTime,
  });

  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  TimeRange copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return TimeRange(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

final StateProvider<TimeRange> timeRangeProvider = StateProvider<TimeRange>(
    (StateProviderRef<TimeRange> ref) => const TimeRange());

final StateProvider<Set<TimeOfDay>> selectedTimesProvider =
    StateProvider<Set<TimeOfDay>>(
        (StateProviderRef<Set<TimeOfDay>> ref) => <TimeOfDay>{});

class FormBuilderTimeField extends HookConsumerWidget {
  const FormBuilderTimeField({
    super.key,
    required this.name,
    required this.decoration,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.use24HourFormat = false,
    this.textStyle,
    this.startTime,
    this.isEndTime = false,
  });

  static const TimeOfDay minTime = TimeOfDay(hour: 7, minute: 0);
  static const TimeOfDay maxTime = TimeOfDay(hour: 20, minute: 0);

  final String name;
  final InputDecoration decoration;
  final TimeOfDay? initialValue;
  final FormFieldValidator<TimeOfDay>? validator;
  final ValueChanged<TimeOfDay?>? onChanged;
  final bool use24HourFormat;
  final TextStyle? textStyle;
  final TimeOfDay? startTime;
  final bool isEndTime;

  String formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final DateTime now = DateTime.now();
    final DateTime dt =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final String format = use24HourFormat ? 'HH:mm' : 'hh:mm a';
    return DateFormat(format).format(dt);
  }

  double _timeToDouble(TimeOfDay time) {
    return time.hour + time.minute / 60.0;
  }

  bool isValidTimeRange(TimeOfDay time, TimeRange currentRange) {
    final double timeValue = _timeToDouble(time);
    final double minValue = _timeToDouble(minTime);
    final double maxValue = _timeToDouble(maxTime);

    // Basic range check
    if (timeValue < minValue || timeValue > maxValue) {
      return false;
    }

    // For end time selection
    if (isEndTime) {
      if (currentRange.startTime != null) {
        final double startValue = _timeToDouble(currentRange.startTime!);
        return timeValue > startValue; // End time must be after start time
      }
    }
    // For start time selection
    else {
      if (currentRange.endTime != null) {
        final double endValue = _timeToDouble(currentRange.endTime!);
        return timeValue < endValue; // Start time must be before end time
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<TimeOfDay?> selectedTime =
        useState<TimeOfDay?>(initialValue);
    final ValueNotifier<String?> errorText = useState<String?>(null);
    final TimeRange currentRange = ref.watch(timeRangeProvider);
    final StateController<Set<TimeOfDay>> timesNotifier =
        ref.read(selectedTimesProvider.notifier);

    bool isTimeUnique(TimeOfDay time) {
      if (!isValidTimeRange(time, currentRange)) {
        if (isEndTime && currentRange.startTime != null) {
          errorText.value =
              'End time must be after ${formatTime(currentRange.startTime)}';
        } else if (!isEndTime && currentRange.endTime != null) {
          errorText.value =
              'Start time must be before ${formatTime(currentRange.endTime)}';
        } else {
          errorText.value = 'Please select a time between 7:00 AM and 8:00 PM';
        }
        return false;
      }

      return true;
    }

    Future<void> selectTime(FormFieldState<TimeOfDay> field) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime.value ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ThemeData.light().colorScheme.copyWith(
                    primary: GlobalStyles.primaryButtonColor,
                    surface: Colors.white,
                    onSurface: Colors.black87,
                  ),
            ),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: use24HourFormat,
              ),
              child: child!,
            ),
          );
        },
      );

      if (picked != null && isTimeUnique(picked)) {
        if (selectedTime.value != null) {
          timesNotifier.update(
              (Set<TimeOfDay> state) => state..remove(selectedTime.value!));
        }

        selectedTime.value = picked;
        timesNotifier.update((Set<TimeOfDay> state) => state..add(picked));

        if (isEndTime) {
          ref.read(timeRangeProvider.notifier).state = TimeRange(
            startTime: currentRange.startTime,
            endTime: picked,
          );
        } else {
          ref.read(timeRangeProvider.notifier).state = TimeRange(
            startTime: picked,
            endTime: currentRange.endTime,
          );
        }

        field.didChange(picked);
        errorText.value = null;
        onChanged?.call(picked);
      }
    }

    useEffect(() {
      if (initialValue != null &&
          isValidTimeRange(initialValue!, currentRange)) {
        selectedTime.value = initialValue;
        timesNotifier
            .update((Set<TimeOfDay> state) => state..add(initialValue!));
      }
      return () {
        if (selectedTime.value != null) {
          timesNotifier.update(
              (Set<TimeOfDay> state) => state..remove(selectedTime.value!));
        }
      };
    }, const <Object?>[]);

    return FormBuilderField<TimeOfDay>(
      name: name,
      validator: validator,
      initialValue: selectedTime.value,
      builder: (FormFieldState<TimeOfDay> field) {
        return InputDecorator(
          decoration: decoration.copyWith(
            errorText: field.errorText ?? errorText.value,
          ),
          child: InkWell(
            onTap: () => selectTime(field),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedTime.value != null
                        ? formatTime(selectedTime.value)
                        : (decoration.hintText ?? 'Select time'),
                    style: textStyle ??
                        TextStyle(
                          fontSize: 16,
                          color: selectedTime.value == null
                              ? Colors.grey.shade600
                              : Colors.black87,
                        ),
                  ),
                ),
                const Icon(
                  Icons.access_time,
                  color: GlobalStyles.primaryButtonColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
