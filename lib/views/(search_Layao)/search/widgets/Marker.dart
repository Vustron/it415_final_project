import 'package:babysitterapp/views/(search_Layao)/search/widgets/Marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker marker(double latitude, double longiitude, String image, Color color) {
  return Marker(
    point: LatLng(latitude, longiitude),
    width: 70,
    height: 70,
    child: MarkerIcon(images: image, color: color),
  );
}
