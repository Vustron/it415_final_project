import 'package:latlong2/latlong.dart';
import 'dart:math';

double calculateDistance(LatLng point1, LatLng point2) {
  const double radiusEarth = 6371;

  final double lat1 = point1.latitude * pi / 180;
  final double lat2 = point2.latitude * pi / 180;
  final double lon1 = point1.longitude * pi / 180;
  final double lon2 = point2.longitude * pi / 180;

  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;

  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return radiusEarth * c;
}
