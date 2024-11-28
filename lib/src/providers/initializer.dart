import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<bool> initializationProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) => false);
