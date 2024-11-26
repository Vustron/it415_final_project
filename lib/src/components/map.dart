import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';

class MapScreen extends HookConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocationController locationController =
        ref.watch(locationControllerProvider.notifier);
    final ValueNotifier<bool> isLoading = useState(true);
    final ValueNotifier<bool> isMarkerMoved = useState(false);
    final ValueNotifier<String?> errorMessage = useState<String?>(null);
    final ValueNotifier<LatLng> selectedLocation = useState<LatLng>(
      const LatLng(7.30041, 125.6815268375),
    );

    Future<void> initLocation() async {
      try {
        isLoading.value = true;
        errorMessage.value = null;
        final Position position = await locationController.getCurrentLocation();
        selectedLocation.value = LatLng(position.latitude, position.longitude);
        isMarkerMoved.value = false;
      } on LocationServiceException catch (e) {
        errorMessage.value = e.message;
        if (context.mounted) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Services Disabled'),
                content: const Text(
                    'Please enable location services to use this feature.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('Open Settings'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Geolocator.openLocationSettings();
                      if (context.mounted) {
                        isLoading.value = true;
                        await initLocation();
                      }
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        errorMessage.value = 'Failed to get location: $e';
      } finally {
        isLoading.value = false;
      }
    }

    Future<void> retryLocation() async {
      errorMessage.value = null;
      isLoading.value = true;
      await initLocation();
    }

    void onMapTap(_, LatLng point) {
      selectedLocation.value = point;
      isMarkerMoved.value = true;
    }

    useEffect(() {
      Future<void>.microtask(() => initLocation());
      return null;
    }, const <Object?>[]);

    if (isLoading.value) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: GlobalStyles.primaryButtonColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: retryLocation,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              initialCenter: selectedLocation.value,
              initialZoom: 13.0,
              onTap: onMapTap,
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
          if (errorMessage.value != null)
            Positioned(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              child: Material(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        errorMessage.value!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: retryLocation,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 50.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(selectedLocation.value),
              child: Text(isMarkerMoved.value
                  ? 'Select Location'
                  : 'Use Current Location'),
            ),
          ),
        ],
      ),
    );
  }
}
