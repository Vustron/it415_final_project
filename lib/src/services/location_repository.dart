import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class LocationRepository {
  LocationRepository(this.logger, this.httpApi);

  final LoggerService logger;
  final HttpApiService httpApi;

  Future<bool> handlePermission() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logger.error('Location services are disabled');
        throw const LocationServiceException(
            'Location services are disabled. Please enable GPS.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logger.error('Location permissions are denied');
          throw const LocationPermissionException('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        logger.error('Location permissions are permanently denied');
        throw const LocationPermissionException(
            'Location permissions are permanently denied. Please enable in settings.');
      }

      logger.info('Location permissions granted');
      return true;
    } catch (e, stackTrace) {
      logger.error('Error handling location permission', e, stackTrace);
      rethrow;
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final bool hasPermission = await handlePermission();
      if (!hasPermission) return null;

      logger.info('Getting current location...');
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      logger.info('Location obtained', <String, double>{
        'latitude': position.latitude,
        'longitude': position.longitude,
      });

      return position;
    } catch (e, stackTrace) {
      logger.error('Error getting current location', e, stackTrace);
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

  Future<String> getAddressFromCoordinates(LatLng? location) async {
    if (location == null) return 'Unknown Location';

    final String? apiUrl = dotenv.env['MAP_API_URL'];

    final Uri uri = Uri.parse(
      '$apiUrl/reverse?lat=${location.latitude}&lon=${location.longitude}&format=json&addressdetails=1',
    );

    try {
      final Map<String, dynamic> response =
          await httpApi.get<Map<String, dynamic>>(uri.toString());
      final NominatimAPI placeData = NominatimAPI.fromJson(response);
      final Address address = placeData.address;

      final List<String> addressParts = <String>[];

      if (address.amenity != null) {
        addressParts.add(address.amenity!);
      }

      if (address.road != null) {
        addressParts.add(address.road!);
      }

      if (address.neighbourhood != null) {
        addressParts.add('Brgy. ${address.neighbourhood}');
      } else if (address.suburb != null) {
        addressParts.add('Brgy. ${address.suburb}');
      }

      if (address.city != null) {
        addressParts.add('${address.city} City');
      }

      if (address.state != null) {
        addressParts.add(address.state!);
      }

      if (addressParts.isEmpty) {
        logger.info('No address components found in response');
        return 'Unknown Location';
      }

      return addressParts.join(', ');
    } catch (e, stackTrace) {
      logger.error('Error fetching address', e, stackTrace);
      return 'Unknown Location';
    }
  }

  Future<Object> getLongitudeAndLatitude(LatLng? location) async {
    if (location == null) return 'Unknown Location';

    final String? apiUrl = dotenv.env['MAP_API_URL'];

    final Uri uri = Uri.parse(
      '$apiUrl/reverse?lat=${location.latitude}&lon=${location.longitude}&format=json&addressdetails=1',
    );

    try {
      final Map<String, dynamic> response =
          await httpApi.get<Map<String, dynamic>>(uri.toString());
      final NominatimAPI placeData = NominatimAPI.fromJson(response);

      return placeData;
    } catch (e, stackTrace) {
      logger.error('Error fetching address', e, stackTrace);
      return 'Unknown Location';
    }
  }
}
