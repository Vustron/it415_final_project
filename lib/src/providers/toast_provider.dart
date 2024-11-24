import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:babysitterapp/src/services.dart';

final Provider<Toast> toastService =
    Provider<Toast>((ProviderRef<Object?> ref) => Toast());
