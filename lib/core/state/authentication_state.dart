import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:babysitterapp/models/user_account.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.loading() = _Loading;

  const factory AuthenticationState.unauthenticated({String? message}) =
      _UnAuthentication;

  const factory AuthenticationState.authenticated({
    required UserAccount user,
  }) = _Authenticated;
}
