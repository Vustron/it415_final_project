import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/views/search.dart';

Marker markerWidget(
    double latitude, double longitude, String image, Color color) {
  return Marker(
    point: LatLng(latitude, longitude),
    width: 70,
    height: 70,
    child: MarkerIcon(images: image, color: color),
  );
}
