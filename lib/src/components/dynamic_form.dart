import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/constants.dart';

class DynamicForm extends HookWidget {
  DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.isLoading,
    this.initialData,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, dynamic>) onSubmit;
  final ValueNotifier<bool>? isLoading;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic>? initialData;

  static const double _borderRadius = 12.0;

  InputDecoration _getInputDecoration(InputFieldConfig field) {
    return InputDecoration(
      labelText: field.label,
      hintText: field.hintText,
      prefixIcon: Icon(field.prefixIcon),
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

  Widget buildFormField(InputFieldConfig field) {
    final dynamic initialValue = initialData?[field.label] ?? field.value;

    switch (field.type) {
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

      case 'file':
        return FormBuilderFilePicker(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as List<PlatformFile>?,
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

      case 'image':
        return FormBuilderImagePicker(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as List<dynamic>?,
          maxImages: 1,
          previewWidth: 150,
          previewHeight: 150,
          validator: FormBuilderValidators.required(
            errorText: 'Please select an image',
          ),
          imageQuality: 70,
          preferredCameraDevice: CameraDevice.front,
          bottomSheetPadding: const EdgeInsets.all(8),
          placeholderImage: const AssetImage('assets/images/placeholder.png'),
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

      default:
        return FormBuilderTextField(
          name: field.label,
          decoration: _getInputDecoration(field),
          initialValue: initialValue as String?,
          validator: FormBuilderValidators.required(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> loading = isLoading ?? useState(false);

    return FormBuilder(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          ...fields.map((InputFieldConfig field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: buildFormField(field),
              )),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: loading.value
                  ? null
                  : () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        onSubmit(_formKey.currentState!.value);
                      }
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadius),
                ),
              ),
              child: loading.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: GlobalStyles.primaryButtonColor,
                        strokeWidth: 2.0,
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
