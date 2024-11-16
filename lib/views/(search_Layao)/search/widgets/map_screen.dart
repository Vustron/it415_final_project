import 'package:babysitterapp/views/(search_Layao)/search/widgets/MarkerLayer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class MapScreen extends HookWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final MapController mapController = useMemoized(() => MapController());

    return FlutterMap(
      // mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(7.3136, 125.6703),
        initialZoom: 15,
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.it415bsit4c.babysitterapp',
        ),
        markerLayer(),
      ],
    );
  }
}
