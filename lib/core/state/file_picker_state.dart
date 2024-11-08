import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_picker_state.freezed.dart';

@freezed
class FilePickerState with _$FilePickerState {
  const factory FilePickerState({
    String? filePath,
    String? fileName,
    String? fileType,
    @Default(false) bool isLoading,
  }) = _FilePickerState;
}
