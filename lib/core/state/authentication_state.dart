// run 'dart run build_runner build' if there's error and no freezed files

// third party
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.loading() = _Loading;

  const factory AuthenticationState.unauthenticated({String? message}) =
      _UnAuthentication;

  const factory AuthenticationState.authenticated({required User user}) =
      _Authenticated;
}
