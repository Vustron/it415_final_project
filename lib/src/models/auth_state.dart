import 'package:babysitterapp/src/models.dart';

class AuthState {
  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.status = AuthStatus.initial,
    this.hasShownToast = false,
  });

  final UserAccount? user;
  final bool isLoading;
  final String? error;
  final AuthStatus status;
  final bool hasShownToast;

  AuthState copyWith({
    UserAccount? user,
    bool? isLoading,
    String? error,
    AuthStatus? status,
    bool? hasShownToast,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      status: status ?? this.status,
      hasShownToast: hasShownToast ?? this.hasShownToast,
    );
  }
}

enum AuthStatus { initial, authenticated, unauthenticated, error }
