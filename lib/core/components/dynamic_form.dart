import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/models/inputfield.dart';

import 'package:babysitterapp/core/helper/shorten_file_name.dart';
import 'package:babysitterapp/core/state/file_picker_state.dart';
import 'package:babysitterapp/core/helper/validate_form.dart';
import 'package:babysitterapp/core/helper/file_preview.dart';
import 'package:babysitterapp/core/helper/file_picker.dart';
import 'package:babysitterapp/core/constants/styles.dart';

import 'select.dart';
import 'input.dart';

class DynamicForm extends HookWidget {
  const DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.isLoading,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, String>) onSubmit;
  final ValueNotifier<bool>? isLoading;

  @override
  Widget build(BuildContext context) {
    final Map<String, TextEditingController> controllers = useMemoized(
      () => Map<String, TextEditingController>.fromEntries(
        fields.map(
          (InputFieldConfig field) => MapEntry<String, TextEditingController>(
            field.label,
            TextEditingController(text: field.value),
          ),
        ),
      ),
      <Object?>[fields],
    );

    final ValueNotifier<Map<String, String>> formData =
        useState<Map<String, String>>(
      Map<String, String>.fromEntries(
        fields.map(
          (InputFieldConfig field) =>
              MapEntry<String, String>(field.label, field.value ?? ''),
        ),
      ),
    );

    final ValueNotifier<Map<String, String?>> errors =
        useState<Map<String, String?>>(
      Map<String, String?>.fromEntries(
        fields.map(
          (InputFieldConfig field) =>
              MapEntry<String, String?>(field.label, null),
        ),
      ),
    );

    useEffect(() {
      return () {
        for (final TextEditingController controller in controllers.values) {
          controller.dispose();
        }
      };
    }, <Object?>[controllers]);

    final ValueNotifier<bool> defaultLoading = useState(false);

    final Map<String, ValueNotifier<FilePickerState>> fileStates = useMemoized(
      () => Map<String, ValueNotifier<FilePickerState>>.fromEntries(
        fields.where((InputFieldConfig field) => field.type == 'file').map(
              (InputFieldConfig field) =>
                  MapEntry<String, ValueNotifier<FilePickerState>>(
                field.label,
                ValueNotifier<FilePickerState>(FilePickerState(
                  filePath: field.value,
                  fileName: field.value?.split('/').last,
                )),
              ),
            ),
      ),
      <Object?>[fields],
    );

    return Column(
      children: <Widget>[
        ...fields.map((InputFieldConfig field) {
          Widget fieldWidget;
          switch (field.type) {
            case 'select':
              fieldWidget = CustomSelect<String>(
                items: field.options ?? <String>[],
                value: field.value,
                hint: field.hintText,
                onChanged: (String? value) {
                  formData.value = <String, String>{
                    ...formData.value,
                    field.label: value ?? '',
                  };
                },
                isRequired: field.isRequired,
                errorText: errors.value[field.label],
                enabled: !(isLoading ?? defaultLoading).value,
              );
              break;

            case 'file':
              final ValueNotifier<FilePickerState> fileState =
                  fileStates[field.label]!;
              fieldWidget = Column(
                children: <Widget>[
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: fileState.value.isLoading ||
                                          (isLoading ?? defaultLoading).value
                                      ? null
                                      : () => pickFile(
                                          field.label,
                                          field.allowedFileTypes,
                                          fileState,
                                          formData),
                                  icon: const Icon(Icons.upload_file),
                                  label: Text(fileState.value.fileName !=
                                              null &&
                                          fileState.value.fileName!.isNotEmpty
                                      ? shortenFileName(
                                          fileState.value.fileName!)
                                      : field.hintText),
                                ),
                              ),
                              if (fileState.value.filePath != null &&
                                  fileState
                                      .value.filePath!.isNotEmpty) ...<Widget>[
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    fileState.value = const FilePickerState();
                                    formData.value = <String, String>{
                                      ...formData.value,
                                      field.label: '',
                                    };
                                    state.didChange(null);
                                  },
                                ),
                              ],
                            ],
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                state.errorText!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          if (fileState.value.isLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: CircularProgressIndicator(
                                color: GlobalStyles.primaryButtonColor,
                              ),
                            )
                          else if (fileState.value.filePath != null &&
                              fileState.value.filePath!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: FilePreview(
                                  filePath: fileState.value.filePath!),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              );
              break;

            case 'text':
            case 'password':
            case 'email':
            default:
              fieldWidget = CustomTextInput(
                controller: controllers[field.label],
                hintText: field.hintText,
                keyboardType: field.keyboardType ?? TextInputType.text,
                obscureText: field.obscureText,
                prefixIcon:
                    field.prefixIcon != null ? Icon(field.prefixIcon) : null,
                onChanged: (String value) {
                  formData.value = <String, String>{
                    ...formData.value,
                    field.label: value,
                  };
                },
                isRequired: field.isRequired,
                minLength: field.minLength,
                maxLength: field.maxLength,
                errorText: errors.value[field.label],
                enabled: !(isLoading ?? defaultLoading).value,
              );
              break;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  field.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                fieldWidget,
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading ?? defaultLoading,
          builder: (BuildContext context, bool loading, Widget? child) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        if (validateForm(fields, formData, errors)) {
                          (isLoading ?? defaultLoading).value = true;
                          onSubmit(formData.value);
                        }
                      },
                child: loading
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
            );
          },
        ),
      ],
    );
  }
}
