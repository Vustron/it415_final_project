import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class FormBuilderSwitchField extends HookWidget {
  const FormBuilderSwitchField({
    super.key,
    required this.name,
    required this.decoration,
    this.initialValue = false,
    this.validator,
    this.onChanged,
    this.activeColor = GlobalStyles.primaryButtonColor,
    this.thumbColor,
    this.trackColor,
    this.subtitle,
  });

  final String name;
  final InputDecoration decoration;
  final bool initialValue;
  final FormFieldValidator<bool>? validator;
  final ValueChanged<bool?>? onChanged;
  final Color activeColor;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> switchValue = useState(initialValue);
    final ValueNotifier<bool> hasError = useState(false);
    final ValueNotifier<String?> errorText = useState<String?>(null);

    return FormBuilderField<bool>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<bool> field) {
        return InputDecorator(
          decoration: decoration.copyWith(
            errorText: field.errorText ?? errorText.value,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              decoration.labelText ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: subtitle,
            trailing: Switch(
              value: switchValue.value,
              onChanged: (bool value) {
                switchValue.value = value;
                field.didChange(value);
                if (validator != null) {
                  final String? error = validator!(value);
                  hasError.value = error != null;
                  errorText.value = error;
                }
                onChanged?.call(value);
              },
              activeColor: activeColor,
              thumbColor: thumbColor,
              trackColor: trackColor,
            ),
          ),
        );
      },
    );
  }
}
