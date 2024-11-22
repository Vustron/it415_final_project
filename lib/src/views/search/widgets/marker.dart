import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

Marker markerWidget(MarkerData markerData, Color color) {
  return Marker(
    point: markerData.position,
    height: 60, 
    width: 60, 
    child: MarkerIcon(
      images: markerData.image,
      color: color,
      markerData: markerData,
    ),
  );
}
