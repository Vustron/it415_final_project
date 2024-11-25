import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:latlong2/latlong.dart';

class LocationController extends StateNotifier<LocationState> {
  LocationController(this.locationService) : super(const LocationState());

  final LocationRepository locationService;

  Future<void> handlePermission() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final bool hasPermission = await locationService.handlePermission();
      if (!hasPermission) {
        state = state.copyWith(
          error: 'Location permission denied',
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<Position> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final Position? position = await locationService.getCurrentLocation();
      if (position != null) {
        state = state.copyWith(
          position: position,
          isLoading: false,
        );
        return position;
      } else {
        throw Exception('Failed to get current location');
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      rethrow;
    }
  }

  Future<void> getAddressFromPosition() async {
    if (state.position == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final String address = await locationService.getAddressFromCoordinates(
        LatLng(state.position!.latitude, state.position!.longitude),
      );

      state = state.copyWith(
        address: address,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  StreamSubscription<Position>? _locationSubscription;

  void startLocationUpdates() {
    _locationSubscription?.cancel();

    _locationSubscription = locationService.getLocationStream().listen(
      (Position position) async {
        state = state.copyWith(position: position);
        await getAddressFromPosition();
      },
      onError: (dynamic error) {
        state = state.copyWith(
          error: error.toString(),
          isLoading: false,
        );
      },
    );
  }

  void stopLocationUpdates() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  @override
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }
}

Position? useLocationUpdates(WidgetRef ref) {
  final StreamController<Position> streamController =
      useStreamController<Position>();
  final LoggerService logger = ref.watch(loggerService);
  final LocationRepository locationService =
      ref.watch(locationRepositoryProvider);

  useEffect(() {
    logger.info('Starting location updates stream');

    final StreamSubscription<Position> subscription =
        locationService.getLocationStream().listen(
      (Position position) {
        logger.debug(
          'Location update received',
          <String, double>{'lat': position.latitude, 'lng': position.longitude},
        );
        streamController.add(position);
      },
      onError: (dynamic error, dynamic stackTrace) {
        logger.error('Location stream error', error, stackTrace as StackTrace?);
      },
    );

    return () {
      logger.info('Disposing location updates stream');
      subscription.cancel();
    };
  }, <Object?>[]);

  final AsyncSnapshot<Position> snapshot = useStream(streamController.stream);
  return snapshot.data;
}
