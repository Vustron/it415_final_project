import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';

class LocationInitNotifier extends StateNotifier<AsyncValue<void>> {
  LocationInitNotifier(this.ref) : super(const AsyncValue<void>.loading());

  final Ref ref;

  Future<void> initialize() async {
    if (state is! AsyncLoading) return;

    try {
      final LocationController locationController =
          ref.read(locationControllerService.notifier);
      await locationController.handlePermission();
      await locationController.getCurrentLocation();
      locationController.startLocationUpdates();
      state = const AsyncValue<void>.data(null);
    } catch (e, stack) {
      state = AsyncValue<void>.error(e, stack);
    }
  }

  @override
  void dispose() {
    ref.read(locationControllerService.notifier).stopLocationUpdates();
    super.dispose();
  }
}

final AutoDisposeStateNotifierProvider<LocationInitNotifier, AsyncValue<void>>
    locationInitProvider =
    StateNotifierProvider.autoDispose<LocationInitNotifier, AsyncValue<void>>(
        (AutoDisposeStateNotifierProviderRef<LocationInitNotifier,
                AsyncValue<void>>
            ref) {
  final LocationInitNotifier notifier = LocationInitNotifier(ref);
  Future<void>.microtask(() => notifier.initialize());
  return notifier;
});
