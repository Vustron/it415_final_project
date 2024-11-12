import 'package:flutter/material.dart';

import 'package:babysitterapp/core/helpers.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/inputfield.dart';

Widget buildFileField(
  InputFieldConfig field,
  ValueNotifier<Map<String, String>> formData,
  Map<String, ValueNotifier<FilePickerState>> fileStates,
  ValueNotifier<bool> isLoading,
) {
  final ValueNotifier<FilePickerState> fileState = fileStates[field.label]!;
  return Column(
    children: <Widget>[
      FormField<String>(
        initialValue: fileState.value.filePath,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (field.isRequired && (value == null || value.isEmpty)) {
            return '${field.label} is required';
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: fileState.value.isLoading || isLoading.value
                          ? null
                          : () async {
                              await pickFile(
                                field.label,
                                field.allowedFileTypes,
                                fileState,
                                formData,
                              );
                              state.didChange(fileState.value.filePath);
                              formData.value = <String, String>{
                                ...formData.value,
                                field.label: fileState.value.filePath ?? '',
                              };
                            },
                      icon: const Icon(Icons.upload_file),
                      label: Text(
                        fileState.value.fileName != null &&
                                fileState.value.fileName!.isNotEmpty
                            ? shortenFileName(fileState.value.fileName!)
                            : field.hintText,
                      ),
                    ),
                  ),
                  if (fileState.value.filePath != null &&
                      fileState.value.filePath!.isNotEmpty) ...<Widget>[
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        fileState.value = const FilePickerState();
                        state.didChange(null);
                        formData.value = <String, String>{
                          ...formData.value,
                          field.label: ''
                        };
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
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              if (fileState.value.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CircularProgressIndicator(),
                )
              else if (fileState.value.filePath != null &&
                  fileState.value.filePath!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: FilePreview(filePath: fileState.value.filePath!),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}
