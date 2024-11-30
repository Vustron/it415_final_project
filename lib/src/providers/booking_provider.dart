import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

final StateNotifierProvider<BookingController, BookingState>
    bookingControllerService =
    StateNotifierProvider<BookingController, BookingState>(
        (StateNotifierProviderRef<BookingController, BookingState> ref) {
  return BookingController(ref.watch(bookingService), ref.watch(authService));
});

final Provider<BookingRepository> bookingService =
    Provider<BookingRepository>((ProviderRef<BookingRepository> ref) {
  return BookingRepository(
    firestore: ref.watch(firebaseFirestoreService),
    logger: ref.watch(loggerService),
  );
});
