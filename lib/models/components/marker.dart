import 'package:latlong2/latlong.dart';

class MarkerData {
  MarkerData({
    required this.position,
    required this.image,
    required this.role,
  });

  final LatLng position;
  final String image;
  final String role;
}
