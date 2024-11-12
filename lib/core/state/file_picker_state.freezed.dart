// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FilePickerState {
  String? get filePath => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get fileType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of FilePickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilePickerStateCopyWith<FilePickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilePickerStateCopyWith<$Res> {
  factory $FilePickerStateCopyWith(
          FilePickerState value, $Res Function(FilePickerState) then) =
      _$FilePickerStateCopyWithImpl<$Res, FilePickerState>;
  @useResult
  $Res call(
      {String? filePath, String? fileName, String? fileType, bool isLoading});
}

/// @nodoc
class _$FilePickerStateCopyWithImpl<$Res, $Val extends FilePickerState>
    implements $FilePickerStateCopyWith<$Res> {
  _$FilePickerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilePickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = freezed,
    Object? fileName = freezed,
    Object? fileType = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileType: freezed == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FilePickerStateImplCopyWith<$Res>
    implements $FilePickerStateCopyWith<$Res> {
  factory _$$FilePickerStateImplCopyWith(_$FilePickerStateImpl value,
          $Res Function(_$FilePickerStateImpl) then) =
      __$$FilePickerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? filePath, String? fileName, String? fileType, bool isLoading});
}

/// @nodoc
class __$$FilePickerStateImplCopyWithImpl<$Res>
    extends _$FilePickerStateCopyWithImpl<$Res, _$FilePickerStateImpl>
    implements _$$FilePickerStateImplCopyWith<$Res> {
  __$$FilePickerStateImplCopyWithImpl(
      _$FilePickerStateImpl _value, $Res Function(_$FilePickerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FilePickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = freezed,
    Object? fileName = freezed,
    Object? fileType = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$FilePickerStateImpl(
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileType: freezed == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FilePickerStateImpl implements _FilePickerState {
  const _$FilePickerStateImpl(
      {this.filePath, this.fileName, this.fileType, this.isLoading = false});

  @override
  final String? filePath;
  @override
  final String? fileName;
  @override
  final String? fileType;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'FilePickerState(filePath: $filePath, fileName: $fileName, fileType: $fileType, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilePickerStateImpl &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, filePath, fileName, fileType, isLoading);

  /// Create a copy of FilePickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilePickerStateImplCopyWith<_$FilePickerStateImpl> get copyWith =>
      __$$FilePickerStateImplCopyWithImpl<_$FilePickerStateImpl>(
          this, _$identity);
}

abstract class _FilePickerState implements FilePickerState {
  const factory _FilePickerState(
      {final String? filePath,
      final String? fileName,
      final String? fileType,
      final bool isLoading}) = _$FilePickerStateImpl;

  @override
  String? get filePath;
  @override
  String? get fileName;
  @override
  String? get fileType;
  @override
  bool get isLoading;

  /// Create a copy of FilePickerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilePickerStateImplCopyWith<_$FilePickerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
