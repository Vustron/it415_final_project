import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/services.dart';

final Provider<LoggerService> loggerProvider = Provider<LoggerService>(
  (ProviderRef<LoggerService> ref) => LoggerService(),
);
