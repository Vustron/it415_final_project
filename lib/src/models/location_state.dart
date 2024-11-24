import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

@immutable
class LocationState {
  const LocationState({
    this.position,
    this.isLoading = false,
    this.error,
  });

  final Position? position;
  final bool isLoading;
  final String? error;

  LocationState copyWith({
    Position? position,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      position: position ?? this.position,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
