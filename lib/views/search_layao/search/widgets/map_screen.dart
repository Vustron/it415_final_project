import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/providers.dart';

import 'package:babysitterapp/models/models.dart';

import 'package:babysitterapp/views/search.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double distance = ref.watch(distanceProvider);

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(7.3136, 125.6703),
        initialZoom: 15,
        minZoom: 10,
        maxZoom: 18,
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.it415bsit4c.babysitterapp',
        ),
        CircleLayer<Object>(
          circles: <CircleMarker<Object>>[
            CircleMarker<Object>(
              point: allMarkers
                  .firstWhere((MarkerData marker) => marker.role == 'client')
                  .position,
              radius: distance * 500,
              color: Colors.lightBlue.withOpacity(0.1),
              borderColor: Colors.lightBlue.withOpacity(0.7),
              borderStrokeWidth: 1,
              useRadiusInMeter: true,
            ),
          ],
        ),
        markerLayer(distance),
      ],
    );
  }
}
