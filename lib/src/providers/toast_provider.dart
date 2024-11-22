import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:babysitterapp/src/services.dart';

final Provider<ToastRepository> toastProvider =
    Provider<ToastRepository>((ProviderRef<Object?> ref) => ToastRepository());
