import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class MapScreen extends HookWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<LatLng> selectedLocation = useState<LatLng>(
      const LatLng(7.30041, 125.6815268375),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(7.30041, 125.6815268375),
              initialZoom: 13.0,
              onTap: (TapPosition tapPosition, LatLng point) {
                selectedLocation.value = point;
              },
            ),
            children: <Widget>[
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: <Marker>[
                  Marker(
                    point: selectedLocation.value,
                    width: 80.0,
                    height: 80.0,
                    child: const Icon(
                      Icons.location_on,
                      color: GlobalStyles.primaryButtonColor,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 50.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedLocation.value);
              },
              child: const Text('Select Location'),
            ),
          ),
        ],
      ),
    );
  }
}
