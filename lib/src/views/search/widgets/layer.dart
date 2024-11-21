import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

final List<MarkerData> allMarkers = <MarkerData>[
  MarkerData(
    position: const LatLng(7.3136, 125.6703),
    image: logo,
    role: 'client',
  ),
  MarkerData(
    position: const LatLng(7.3164, 125.6833),
    image: avatar2,
    role: 'babysitter',
  ),
  MarkerData(
    position: const LatLng(7.3087, 125.6841),
    image: avatar1,
    role: 'babysitter',
  ),
];

MarkerLayer markerLayer(double radius) {
  final LatLng clientPosition = allMarkers
      .firstWhere((MarkerData marker) => marker.role == 'client')
      .position;

  final List<Marker> visibleMarkers = allMarkers.where((MarkerData markerData) {
    if (markerData.role == 'client') {
      return true;
    }

    final double distance = calculateDistance(
      clientPosition,
      markerData.position,
    );

    return distance <= (radius * 0.5);
  }).map((MarkerData markerData) {
    return markerWidget(
      markerData.position.latitude,
      markerData.position.longitude,
      markerData.image,
      markerData.role == 'client' ? Colors.lightBlue : Colors.pink.shade300,
    );
  }).toList();

  return MarkerLayer(markers: visibleMarkers);
}
