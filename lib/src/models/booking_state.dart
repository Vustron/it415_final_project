import 'package:babysitterapp/src/models.dart';

class BookingState {
  BookingState({
    this.bookings = const <Booking>[],
    this.booking,
    this.isLoading = false,
    this.error,
  });

  final List<Booking> bookings;
  final Booking? booking;
  final bool isLoading;
  final String? error;

  BookingState copyWith({
    List<Booking>? bookings,
    Booking? booking,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      booking: booking ?? this.booking,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
