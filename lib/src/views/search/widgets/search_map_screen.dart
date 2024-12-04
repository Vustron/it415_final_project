import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

final StreamProvider<List<UserAccount>> usersStreamProvider =
    StreamProvider<List<UserAccount>>(
        (StreamProviderRef<List<UserAccount>> ref) {
  final AuthController authController =
      ref.watch(authControllerService.notifier);
  return authController.getBabysittersStream();
});

// Update SearchMapScreen
class SearchMapScreen extends HookConsumerWidget {
  const SearchMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double distance = ref.watch(distanceService);
    final String searchQuery = ref.watch(searchQueryProvider);
    final MarkerData? selectedMarker = ref.watch(selectedMarkerService);
    final UserAccount? currentUser = ref.watch(authControllerService).user;
    final AsyncValue<List<UserAccount>> usersAsync =
        ref.watch(usersStreamProvider);

    return usersAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (Object error, StackTrace stack) => Center(
        child: Text('Error: $error'),
      ),
      data: (List<UserAccount> users) {
        final List<UserAccount> filteredUsers = users.where((UserAccount user) {
          if (searchQuery.isEmpty) return true;
          return user.name?.toLowerCase().contains(searchQuery) ?? false;
        }).toList();

        final List<MarkerData> markers = <MarkerData>[
          if (currentUser != null)
            MarkerData(
              user: currentUser,
              role: 'client',
            ),
          ...filteredUsers.map((UserAccount user) => MarkerData(
                user: user,
                role: 'babysitter',
              )),
        ];

        final MarkerData clientMarker =
            markers.firstWhere((MarkerData m) => m.role == 'client');

        return Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(
                initialCenter: clientMarker.position,
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
                // Distance circle
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: distance * 500),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (_, double animatedRadius, __) =>
                      CircleLayer<Object>(
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
                // Polyline to selected marker
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
                // Filtered markers
                MarkerLayer(
                  markers:
                      _buildMarkers(markers, distance, clientMarker.position),
                ),
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
      },
    );
  }

  List<Marker> _buildMarkers(
    List<MarkerData> markers,
    double radius,
    LatLng clientPosition,
  ) {
    return markers
        .where((MarkerData marker) {
          if (marker.role == 'client') return true;

          final double distance = calculateDistance(
            clientPosition,
            marker.position,
          );

          return distance <= (radius * 0.5);
        })
        .map((MarkerData marker) => markerWidget(
              marker,
              marker.role == 'client' ? Colors.lightBlue : Colors.pink.shade300,
            ))
        .toList();
  }
}
