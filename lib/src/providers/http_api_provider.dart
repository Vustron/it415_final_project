import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';

final Provider<HttpApiService> httpApiService =
    Provider<HttpApiService>((ProviderRef<HttpApiService> ref) {
  final LoggerService logger = ref.watch(loggerService);
  return HttpApiService(Dio(), logger);
});
