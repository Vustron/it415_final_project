import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class SearchMapScreen extends HookConsumerWidget {
  const SearchMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double distance = ref.watch(distanceService);
    final MarkerData? selectedMarker = ref.watch(selectedMarkerService);
    final MarkerData clientMarker =
        allMarkers.firstWhere((MarkerData marker) => marker.role == 'client');

    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(7.3136, 125.6703),
            initialZoom: 15,
            minZoom: 10,
            maxZoom: 18,
            onTap: (_, __) {
              ref.read(selectedMarkerService.notifier).state = null;
            },
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.it415bsit4c.babysitterapp',
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: distance * 500),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              builder: (_, double animatedRadius, __) => CircleLayer<Object>(
                circles: <CircleMarker<Object>>[
                  CircleMarker<Object>(
                    point: clientMarker.position,
                    radius: animatedRadius,
                    color: Colors.lightBlue.withOpacity(0.1),
                    borderColor: Colors.lightBlue.withOpacity(0.7),
                    borderStrokeWidth: 1,
                    useRadiusInMeter: true,
                  ),
                ],
              ),
            ),
            if (selectedMarker != null)
              PolylineLayer<Object>(
                polylines: <Polyline<Object>>[
                  Polyline<Object>(
                    points: <LatLng>[
                      clientMarker.position,
                      selectedMarker.position,
                    ],
                    color: Colors.blue,
                    strokeWidth: 3.0,
                  ),
                ],
              ),
            markerLayer(distance),
          ],
        ),
        if (selectedMarker != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SelectedMarkerSheet(
              markerData: selectedMarker,
              clientPosition: clientMarker.position,
            ),
          ),
      ],
    );
  }
}
