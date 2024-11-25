import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

@immutable
class LocationState {
  const LocationState({
    this.position,
    this.address,
    this.isLoading = false,
    this.error,
  });

  final Position? position;
  final String? address;
  final bool isLoading;
  final String? error;

  LocationState copyWith({
    Position? position,
    String? address,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      position: position ?? this.position,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
