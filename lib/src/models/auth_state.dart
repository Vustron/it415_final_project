import 'package:babysitterapp/src/models.dart';

class AuthState {
  AuthState({
    this.user,
    this.users = const <UserAccount>[],
    this.isLoading = false,
    this.error,
    this.status = AuthStatus.initial,
    this.hasShownToast = false,
  });

  final UserAccount? user;
  final List<UserAccount> users;
  final bool isLoading;
  final String? error;
  final AuthStatus status;
  final bool hasShownToast;

  AuthState copyWith({
    UserAccount? user,
    List<UserAccount>? users,
    bool? isLoading,
    String? error,
    AuthStatus? status,
    bool? hasShownToast,
  }) {
    return AuthState(
      user: user ?? this.user,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      status: status ?? this.status,
      hasShownToast: hasShownToast ?? this.hasShownToast,
    );
  }
}

enum AuthStatus { initial, authenticated, unauthenticated, error }
