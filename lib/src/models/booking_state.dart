import 'package:babysitterapp/src/models.dart';

class BookingState {
  BookingState({
    this.bookings = const <Booking>[],
    this.isLoading = false,
    this.error,
  });

  final List<Booking> bookings;
  final bool isLoading;
  final String? error;

  BookingState copyWith({
    List<Booking>? bookings,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
