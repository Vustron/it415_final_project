import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:babysitterapp/src/models.dart';

final StateProvider<MarkerData?> selectedMarkerProvider =
    StateProvider<MarkerData?>((StateProviderRef<MarkerData?> ref) => null);
