import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class Availability {
  const Availability(this.day, this.periods);
  final String day;
  final List<String> periods;

  @override
  String toString() => '$day: ${periods.join(", ")}';
}

class FormBuilderAvailabilityField
    extends FormBuilderField<Map<String, List<String>>> {
  FormBuilderAvailabilityField({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    required InputDecoration decoration,
    super.onChanged,
  }) : super(
          builder: (FormFieldState<Map<String, List<String>>> field) {
            final _AvailabilityFieldState state =
                field as _AvailabilityFieldState;
            return InputDecorator(
              decoration: decoration.copyWith(
                errorText: state.errorText,
              ),
              child: AvailabilityGrid(
                value: state._value,
                onChanged: (Map<String, List<String>> val) =>
                    state.didChange(val),
              ),
            );
          },
        );

  @override
  FormBuilderFieldState<FormBuilderAvailabilityField, Map<String, List<String>>>
      createState() => _AvailabilityFieldState();
}

class _AvailabilityFieldState extends FormBuilderFieldState<
    FormBuilderAvailabilityField, Map<String, List<String>>> {
  static const List<String> _days = <String>[
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su'
  ];
  // ignore: unused_field
  static const List<String> _periods = <String>[
    'Morning',
    'Afternoon',
    'Evening'
  ];

  Map<String, List<String>> get _value =>
      value ??
      Map<String, List<String>>.fromIterables(
          _days, List<List<String>>.generate(_days.length, (_) => <String>[]));

  String? validateAvailability(Map<String, List<String>>? value) {
    if (value == null) return 'Please select your availability';
    if (value.values.every((List<String> periods) => periods.isEmpty)) {
      return 'Please select at least one time slot';
    }
    return null;
  }
}

class AvailabilityGrid extends StatelessWidget {
  const AvailabilityGrid({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final Map<String, List<String>> value;
  final ValueChanged<Map<String, List<String>>> onChanged;

  static const List<String> _days = <String>[
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su'
  ];
  static const List<String> _periods = <String>[
    'Morning',
    'Afternoon',
    'Evening'
  ];
  static const Map<String, String> _dayLabels = <String, String>{
    'Mo': 'Monday',
    'Tu': 'Tuesday',
    'We': 'Wednesday',
    'Th': 'Thursday',
    'Fr': 'Friday',
    'Sa': 'Saturday',
    'Su': 'Sunday',
  };

  void _togglePeriod(String day, String period) {
    final Map<String, List<String>> newValue =
        Map<String, List<String>>.from(value);
    if (newValue[day]!.contains(period)) {
      newValue[day]!.remove(period);
    } else {
      newValue[day]!.add(period);
    }
    onChanged(newValue);
  }

  void _toggleDay(String day) {
    final Map<String, List<String>> newValue =
        Map<String, List<String>>.from(value);
    if (newValue[day]!.length == _periods.length) {
      newValue[day] = <String>[];
    } else {
      newValue[day] = List<String>.from(_periods);
    }
    onChanged(newValue);
  }

  void _togglePeriodForAllDays(String period) {
    final Map<String, List<String>> newValue =
        Map<String, List<String>>.from(value);
    final bool allDaysHavePeriod =
        _days.every((String day) => value[day]!.contains(period));

    for (final String day in _days) {
      if (allDaysHavePeriod) {
        newValue[day]!.remove(period);
      } else if (!newValue[day]!.contains(period)) {
        newValue[day]!.add(period);
      }
    }
    onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Tooltip(
              message: 'Time Periods',
              child: SizedBox(
                width: 80,
                child: IconButton(
                  icon: const Icon(Icons.help_outline, size: 20),
                  onPressed: () {},
                ),
              ),
            ),
            ...List<Widget>.generate(
              _days.length,
              (int index) => Expanded(
                child: Tooltip(
                  message: _dayLabels[_days[index]],
                  child: InkWell(
                    onTap: () => _toggleDay(_days[index]),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _days[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List<Widget>.generate(
          _periods.length,
          (int periodIndex) => Row(
            children: <Widget>[
              SizedBox(
                width: 80,
                child: InkWell(
                  onTap: () => _togglePeriodForAllDays(_periods[periodIndex]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      _periods[periodIndex],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ),
              ...List<Widget>.generate(
                _days.length,
                (int dayIndex) => Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _togglePeriod(
                              _days[dayIndex], _periods[periodIndex]),
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: value[_days[dayIndex]]!
                                      .contains(_periods[periodIndex])
                                  ? GlobalStyles.primaryButtonColor
                                      .withOpacity(0.1)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: value[_days[dayIndex]]!
                                        .contains(_periods[periodIndex])
                                    ? GlobalStyles.primaryButtonColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: value[_days[dayIndex]]!
                                    .contains(_periods[periodIndex])
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: GlobalStyles.primaryButtonColor,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
