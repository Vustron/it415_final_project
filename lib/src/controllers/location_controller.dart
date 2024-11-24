import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class LocationController extends StateNotifier<LocationState> {
  LocationController(this._locationService) : super(const LocationState());

  final LocationRepository _locationService;

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final Position? position = await _locationService.getCurrentLocation();
      if (position != null) {
        state = state.copyWith(position: position, isLoading: false);
      } else {
        state = state.copyWith(
          error: 'Unable to get location',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}
