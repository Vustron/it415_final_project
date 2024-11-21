import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';

Either<AuthFailure, String> validateEmail(String email) {
  if (email.isEmpty) {
    return left(AuthFailure('Email cannot be empty'));
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return left(
      AuthFailure('Invalid email format'),
    );
  }
  return right(email);
}

Either<AuthFailure, String> validatePassword(String password) {
  if (password.isEmpty) {
    return left(AuthFailure('Password cannot be empty'));
  }
  if (password.length < 6) {
    return left(AuthFailure('Password must be at least 8 characters'));
  }
  return right(password);
}

Either<AuthFailure, String> validateName(String name) {
  if (name.isEmpty) {
    return left(AuthFailure('Name cannot be empty'));
  }
  if (name.length < 2) {
    return left(AuthFailure('Name must be at least 2 characters'));
  }
  return right(name);
}
