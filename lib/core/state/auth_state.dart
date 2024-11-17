import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:babysitterapp/models/models.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.unauthenticated({String? message}) =
      _UnAuthentication;

  const factory AuthState.authenticated({
    required UserAccount user,
  }) = _Authenticated;

  const factory AuthState.error({
    required String message,
    StackTrace? stackTrace,
  }) = _Error;
}
