import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

Future<String?> getAddressFromLocation(LatLng? location) async {
  if (location == null) {
    return null;
  }

  try {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks.first;
      return '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
    }
  } catch (e) {
    debugPrint('Error getting address from location: $e');
  }

  return null;
}
