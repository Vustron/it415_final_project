import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/models/user_account.dart';

class MapView extends HookWidget {
  const MapView({
    super.key,
    required this.onLocationSelected,
    required this.user,
  });

  final UserAccount user;

  final void Function(String address, LatLng location) onLocationSelected;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<LatLng?> selectedLocation = useState<LatLng?>(null);
    final ValueNotifier<bool> isLoading = useState(true);
    final ValueNotifier<MapController> mapController =
        useState(MapController());
    final AnimationController pulseAnimation = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat();

    useEffect(() {
      checkPermissionAndGetLocation(selectedLocation, isLoading);
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Location',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: mapController.value,
            options: MapOptions(
              initialCenter: selectedLocation.value ?? const LatLng(0, 0),
              initialZoom: 15,
              onTap: (TapPosition tapPosition, LatLng point) {
                selectedLocation.value = point;
              },
            ),
            children: <Widget>[
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.it415bsit4c.babysitterapp',
              ),
              if (selectedLocation.value != null)
                MarkerLayer(
                  markers: <Marker>[
                    Marker(
                      point: selectedLocation.value!,
                      width: 80,
                      height: 80,
                      child: AnimatedBuilder(
                        animation: pulseAnimation,
                        builder: (BuildContext context, Widget? child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              // Pulsing circle
                              Transform.scale(
                                scale: 1 + pulseAnimation.value * 0.5,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              // User avatar
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  image: DecorationImage(
                                    image: user.profileImg != null
                                        ? NetworkImage(user.profileImg!)
                                        : const AssetImage(
                                            avatar1,
                                          ) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Tap on the map to select your location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalStyles.primaryButtonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: selectedLocation.value == null
                      ? null
                      : () {
                          onLocationSelected(
                            'Selected Location',
                            selectedLocation.value!,
                          );
                          Navigator.pop(context);
                        },
                  child: const Text(
                    'Confirm Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkPermissionAndGetLocation(
    ValueNotifier<LatLng?> selectedLocation,
    ValueNotifier<bool> isLoading,
  ) async {
    final PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      try {
        final Position position = await Geolocator.getCurrentPosition();
        selectedLocation.value = LatLng(position.latitude, position.longitude);
      } catch (e) {
        debugPrint('Error getting location: $e');
      }
    }
    isLoading.value = false;
  }
}
