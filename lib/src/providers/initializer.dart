import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<bool> initializationService =
    StateProvider<bool>((StateProviderRef<bool> ref) => false);
