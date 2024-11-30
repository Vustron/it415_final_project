import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class BookingController extends StateNotifier<BookingState> {
  BookingController(this.bookingRepo) : super(BookingState());

  final BookingRepository bookingRepo;

  Future<void> createBooking(
    String parentId,
    String babysitterId,
    Map<String, dynamic> formData,
  ) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final Booking booking = Booking(
        parentId: parentId,
        babysitterId: babysitterId,
        numberOfChildren: formData['Number of Children'] as int,
        stayIn: formData['Stay In'] as bool,
        workingDate: formData['Working Date'] as DateTime,
        address: formData['Address'] as String,
        addressLatitude: formData['AddressLatitude'] as String,
        addressLongitude: formData['AddressLongitude'] as String,
        startTime: formData['Start Time'] as String,
        endTime: formData['End Time'] as String,
        details: formData['Additional details'] as String,
      );

      final Either<BookingFailure, Booking> result =
          await bookingRepo.createBooking(booking);

      result.fold(
        (BookingFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
        (Booking booking) => state = state.copyWith(
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Stream<List<Booking>> getBookingsStream(UserAccount user) {
    return bookingRepo.getBookingsStream(
      userId: user.id!,
      role: user.role!,
    );
  }

  Future<void> updateBookingStatus(String bookingId, String status) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    final Either<BookingFailure, Unit> result =
        await bookingRepo.updateBookingStatus(bookingId, status);

    result.fold(
      (BookingFailure failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }
}
