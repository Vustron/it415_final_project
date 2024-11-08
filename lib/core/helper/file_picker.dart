import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:babysitterapp/core/state/file_picker_state.dart';

Future<void> pickFile(
  String label,
  List<String>? allowedFileTypes,
  ValueNotifier<FilePickerState> fileState,
  ValueNotifier<Map<String, String>> formData,
) async {
  fileState.value = fileState.value.copyWith(isLoading: true);

  try {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedFileTypes ??
          <String>['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      final String filePath = result.files.single.path!;
      final String fileName = result.files.single.name;
      final String fileType = path.extension(fileName);

      fileState.value = FilePickerState(
        filePath: filePath,
        fileName: fileName,
        fileType: fileType,
      );

      formData.value = <String, String>{
        ...formData.value,
        label: filePath,
      };
    }
  } finally {
    if (fileState.value.filePath == null) {
      fileState.value = fileState.value.copyWith(isLoading: false);
    }
  }
}
