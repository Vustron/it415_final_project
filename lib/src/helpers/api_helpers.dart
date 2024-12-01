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

DateTime parseTimeString(String timeStr) {
  timeStr = timeStr.trim();

  final bool isPM = timeStr.toLowerCase().contains('pm');
  timeStr = timeStr.toLowerCase().replaceAll(RegExp(r'[ap]m'), '').trim();

  final List<String> parts = timeStr.split(':');
  int hours = int.parse(parts[0]);
  final int minutes = int.parse(parts[1]);

  if (isPM && hours != 12) {
    hours += 12;
  } else if (!isPM && hours == 12) {
    hours = 0;
  }

  return DateTime(2024, 1, 1, hours, minutes);
}

Map<String, List<String>>? convertAvailabilityToMap(dynamic value) {
  if (value == null) return null;

  if (value is Map<String, List<String>>) {
    return value;
  }

  if (value is List<String>) {
    final Map<String, List<String>> result = <String, List<String>>{
      'Mo': <String>[],
      'Tu': <String>[],
      'We': <String>[],
      'Th': <String>[],
      'Fr': <String>[],
      'Sa': <String>[],
      'Su': <String>[]
    };

    for (final String slot in value) {
      final List<String> parts = slot.split(': ');
      if (parts.length == 2) {
        final String day = parts[0];
        final List<String> periods = parts[1].split(', ');
        result[day] = periods;
      }
    }
    return result;
  }

  return null;
}
