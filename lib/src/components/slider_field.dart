import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class FormBuilderSliderField extends HookWidget {
  const FormBuilderSliderField({
    super.key,
    required this.name,
    required this.decoration,
    required this.min,
    required this.max,
    this.initialValue,
    this.divisions,
    this.validator,
    this.onChanged,
    this.activeColor = GlobalStyles.primaryButtonColor,
    this.showLabels = true,
    this.isInteger = false,
  });

  final String name;
  final InputDecoration decoration;
  final double min;
  final double max;
  final double? initialValue;
  final int? divisions;
  final FormFieldValidator<double>? validator;
  final ValueChanged<double?>? onChanged;
  final Color activeColor;
  final bool showLabels;
  final bool isInteger;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> currentValue =
        useState<double>(initialValue ?? min);
    final ValueNotifier<bool> hasError = useState(false);
    final ValueNotifier<String?> errorText = useState<String?>(null);

    void validateValue(double value) {
      if (validator != null) {
        final String? error = validator!(value);
        hasError.value = error != null;
        errorText.value = error;
      }
    }

    String formatValue(double value) {
      if (isInteger) {
        return value.round().toString();
      }
      return value.toStringAsFixed(1);
    }

    return FormBuilderField<double>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<double> field) {
        return InputDecorator(
          decoration: decoration.copyWith(
            errorText: field.errorText ?? errorText.value,
          ),
          child: Column(
            children: <Widget>[
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: activeColor,
                  inactiveTrackColor: activeColor.withOpacity(0.3),
                  thumbColor: activeColor,
                  overlayColor: activeColor.withOpacity(0.2),
                ),
                child: Slider(
                  value: currentValue.value,
                  min: min,
                  max: max,
                  divisions:
                      divisions ?? (isInteger ? (max - min).round() : null),
                  onChanged: (double value) {
                    final double newValue =
                        isInteger ? value.roundToDouble() : value;
                    currentValue.value = newValue;
                    field.didChange(newValue);
                    validateValue(newValue);
                    onChanged?.call(newValue);
                  },
                ),
              ),
              if (showLabels)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(formatValue(min)),
                      Text(
                        formatValue(currentValue.value),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: activeColor,
                        ),
                      ),
                      Text(formatValue(max)),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
