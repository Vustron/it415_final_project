import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

final Provider<LocationRepository> locationService =
    Provider<LocationRepository>((ProviderRef<LocationRepository> ref) {
  final LoggerService logger = ref.watch(loggerService);
  final HttpApiService httpApi = ref.watch(httpApiService);
  return LocationRepository(logger, httpApi);
});

final StateNotifierProvider<LocationController, LocationState>
    locationControllerService =
    StateNotifierProvider<LocationController, LocationState>(
        (StateNotifierProviderRef<LocationController, LocationState> ref) {
  final LocationRepository locationRepository = ref.watch(locationService);
  return LocationController(locationRepository);
});

final StateProvider<double> distanceService =
    StateProvider<double>((StateProviderRef<double> ref) => 1);
