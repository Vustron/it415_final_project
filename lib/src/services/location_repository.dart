import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/async.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';

class LocationRepository {
  LocationRepository(this._logger);

  final LoggerService _logger;

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _logger.error('Location services are disabled');
        return false;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _logger.error('Location permissions are denied');
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _logger.error('Location permissions are permanently denied');
        return false;
      }

      _logger.info('Location permissions granted');
      return true;
    } catch (e, stackTrace) {
      _logger.error('Error handling location permission', e, stackTrace);
      return false;
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final bool hasPermission = await _handlePermission();
      if (!hasPermission) return null;

      _logger.info('Getting current location...');
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _logger.info('Location obtained', <String, double>{
        'latitude': position.latitude,
        'longitude': position.longitude,
      });

      return position;
    } catch (e, stackTrace) {
      _logger.error('Error getting current location', e, stackTrace);
      return null;
    }
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
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
