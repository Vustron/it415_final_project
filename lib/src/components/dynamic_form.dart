import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';

class DynamicForm extends HookConsumerWidget {
  DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.isLoading,
    this.initialData,
    this.userId,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, dynamic>) onSubmit;
  final ValueNotifier<bool>? isLoading;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic>? initialData;
  final String? userId;

  static const double _borderRadius = 12.0;

  InputDecoration _getInputDecoration(InputFieldConfig field) {
    return InputDecoration(
      labelText: field.label,
      hintText: field.hintText,
      prefixIcon: Icon(field.prefixIcon),
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: GlobalStyles.primaryButtonColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget buildFormField(BuildContext context, InputFieldConfig field) {
    final dynamic initialValue = initialData?[field.label] ?? field.value;

    if (field.type == 'image') {
      return ImageField(
        name: field.label,
        decoration: _getInputDecoration(field),
        userId: userId ?? '',
        initialValue: initialValue as String?,
        onChanged: (String? url) {
          if (url != null) {
            _formKey.currentState?.fields[field.label]?.didChange(url);
          }
        },
      );
    }

    if (field.type == 'address') {
      return AddressField(
        name: field.label,
        decoration: _getInputDecoration(field),
        initialValue: initialValue as String?,
      );
    }

    switch (field.type) {
      case 'phone':
        return FormBuilderTextField(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as String?,
          keyboardType: TextInputType.phone,
          validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
            FormBuilderValidators.minLength(11),
            FormBuilderValidators.maxLength(11),
            (String? value) {
              if (value == null || !value.startsWith('09')) {
                return 'Phone number must start with 09';
              }
              return null;
            },
          ]),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        );

      case 'select':
        return FormBuilderDropdown<String>(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as String?,
          items: field.options
                  ?.map((String option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      ))
                  .toList() ??
              <DropdownMenuItem<String>>[],
          validator: FormBuilderValidators.required(),
        );

      case 'date':
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: GlobalStyles.primaryButtonColor,
                  surface: Colors.white,
                  onSurface: Colors.black87,
                ),
            dialogBackgroundColor: Colors.white,
          ),
          child: FormBuilderDateTimePicker(
            name: field.label,
            decoration: _getInputDecoration(field),
            initialValue: initialValue as DateTime?,
            inputType: InputType.date,
            format: DateFormat('yyyy-MM-dd'),
            validator:
                field.isRequired ? FormBuilderValidators.required() : null,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            style: const TextStyle(
              fontSize: 16,
            ),
            keyboardType: TextInputType.none,
          ),
        );

      case 'file':
        return FormBuilderFilePicker(
          name: field.label,
          decoration: _getInputDecoration(field),
          maxFiles: 1,
          typeSelectors: const <TypeSelector>[
            TypeSelector(
              type: FileType.custom,
              selector: Text('Select File'),
            ),
          ],
          allowedExtensions: const <String>['jpg', 'png', 'pdf'],
          onChanged: (List<PlatformFile>? val) {},
          withData: true,
        );

      case 'password':
        final ValueNotifier<bool> showPassword = useState(false);
        return FormBuilderTextField(
          name: field.label,
          obscureText: !showPassword.value,
          decoration: _getInputDecoration(field).copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                showPassword.value
                    ? FluentIcons.eye_off_24_regular
                    : FluentIcons.eye_24_regular,
                size: 20,
              ),
              onPressed: () => showPassword.value = !showPassword.value,
            ),
          ),
          initialValue: initialValue as String?,
          validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
          ]),
        );

      case 'email':
        return FormBuilderTextField(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as String?,
          keyboardType: TextInputType.emailAddress,
          validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        );

      case 'slider':
        return FormBuilderSliderField(
          name: field.label,
          decoration: _getInputDecoration(field),
          min: field.min ?? 0,
          max: field.max ?? 100,
          initialValue: (initialValue as num?)?.toDouble(),
          divisions: field.divisions,
          validator: field.isRequired
              ? FormBuilderValidators.compose(<FormFieldValidator<double>>[
                  FormBuilderValidators.required(),
                  (double? value) {
                    if (value == null) return 'Required';
                    if (value < field.min!) return 'Too low';
                    if (value > field.max!) return 'Too high';
                    return null;
                  },
                ])
              : null,
        );

      case 'switch':
        return FormBuilderSwitchField(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as bool? ?? false,
          subtitle: Text(field.hintText),
          validator: field.isRequired
              ? FormBuilderValidators.compose(<FormFieldValidator<bool>>[
                  FormBuilderValidators.required(),
                  (bool? value) {
                    if (value == null) return 'Required';
                    return null;
                  },
                ])
              : null,
        );

      case 'timeRange':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(field.label, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            TimeRangePicker(
              startFieldName: '${field.label}_start',
              endFieldName: '${field.label}_end',
              initialStartTime: initialValue is Map
                  ? TimeOfDay(
                      hour: (initialValue['start'] as DateTime?)?.hour ?? 7,
                      minute: (initialValue['start'] as DateTime?)?.minute ?? 0)
                  : null,
              initialEndTime: initialValue is Map
                  ? TimeOfDay(
                      hour: (initialValue['end'] as DateTime?)?.hour ?? 17,
                      minute: (initialValue['end'] as DateTime?)?.minute ?? 0)
                  : null,
            ),
          ],
        );

      case 'textarea':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilderTextField(
              name: field.label,
              decoration: _getInputDecoration(field).copyWith(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical:
                      field.minLines != null ? field.minLines! * 12.0 : 20,
                ),
                // Remove default counter
                counter: const SizedBox.shrink(),
              ),
              initialValue: initialValue as String?,
              maxLines: field.maxLines ?? 4,
              minLines: field.minLines ?? 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              validator: field.isRequired
                  ? FormBuilderValidators.compose(<FormFieldValidator<String>>[
                      FormBuilderValidators.required(),
                      if (field.maxLength != null)
                        FormBuilderValidators.maxLength(field.maxLength!),
                      if (field.minLength != null)
                        FormBuilderValidators.minLength(field.minLength!),
                    ])
                  : null,
              maxLength: field.maxLength,
            ),
            // Custom counter and error container
            Builder(
              builder: (BuildContext context) {
                final FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>?
                    fieldState = FormBuilder.of(context)?.fields[field.label];
                final int currentLength =
                    (fieldState?.value as String?)?.length ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(top: 4, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (fieldState?.hasError ?? false)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            fieldState?.errorText ?? '',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (field.maxLength != null)
                        Text(
                          '$currentLength/${field.maxLength}',
                          style: TextStyle(
                            color: currentLength >=
                                    (field.maxLength ?? double.infinity)
                                ? Colors.red
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        );

      default:
        return FormBuilderTextField(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as String?,
          validator: field.isRequired ? FormBuilderValidators.required() : null,
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          ...fields.map(
            (InputFieldConfig field) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: buildFormField(context, field),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading?.value ?? false
                  ? null
                  : () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        onSubmit(_formKey.currentState!.value);
                      }
                    },
              child: isLoading?.value ?? false
                  ? const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        color: GlobalStyles.primaryButtonColor,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
