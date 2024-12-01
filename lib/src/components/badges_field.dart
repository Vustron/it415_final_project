import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class FormBuilderBadgeField extends FormBuilderField<List<String>> {
  FormBuilderBadgeField({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    InputDecoration? decoration,
    required this.options,
    this.isMultiSelect = false,
    this.isCancellable = true,
    this.badgeColor,
    this.selectedBadgeColor,
    this.textColor,
    this.selectedTextColor,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
  }) : super(
          builder: (FormFieldState<List<String>> field) {
            final _FormBuilderBadgeFieldState state =
                field as _FormBuilderBadgeFieldState;

            return InputDecorator(
              decoration: decoration ?? const InputDecoration(),
              child: Wrap(
                spacing: spacing,
                runSpacing: runSpacing,
                children: options.map((String option) {
                  final bool isSelected =
                      state.value?.contains(option) ?? false;
                  return InkWell(
                    onTap: () => state.toggleOption(option),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? selectedBadgeColor ??
                                GlobalStyles.primaryButtonColor
                            : badgeColor ?? Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected
                              ? selectedTextColor ?? Colors.white
                              : textColor ?? Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );

  final List<String> options;
  final bool isMultiSelect;
  final bool isCancellable;
  final Color? badgeColor;
  final Color? selectedBadgeColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double spacing;
  final double runSpacing;

  @override
  FormBuilderFieldState<FormBuilderBadgeField, List<String>> createState() =>
      _FormBuilderBadgeFieldState();
}

class _FormBuilderBadgeFieldState
    extends FormBuilderFieldState<FormBuilderBadgeField, List<String>> {
  void toggleOption(String option) {
    final List<String> currentValue = value ?? <String>[];

    if (widget.isMultiSelect) {
      if (currentValue.contains(option)) {
        if (widget.isCancellable) {
          didChange(
            currentValue.where((String item) => item != option).toList(),
          );
        }
      } else {
        didChange(<String>[...currentValue, option]);
      }
    } else {
      if (currentValue.contains(option)) {
        if (widget.isCancellable) {
          didChange(<String>[]);
        }
      } else {
        didChange(<String>[option]);
      }
    }
  }
}
