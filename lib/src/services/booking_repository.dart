import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class BookingFailure {
  BookingFailure(this.message);
  final String message;
}

class BookingRepository {
  BookingRepository({
    required FirebaseFirestore firestore,
    required LoggerService logger,
  })  : _firestore = firestore,
        _logger = logger;

  final FirebaseFirestore _firestore;
  final LoggerService _logger;

  Future<Either<BookingFailure, Booking>> createBooking(Booking booking) async {
    try {
      _logger.info('Creating booking for parent: ${booking.parentId}');

      final String id = NanoIdGenerator.generate();
      final Map<String, dynamic> data = <String, dynamic>{
        ...booking.toJson(),
        'id': id
      };

      await _firestore.collection('bookings').doc(id).set(data);

      return right(Booking.fromJson(data));
    } catch (e, stack) {
      _logger.error('Failed to create booking', e, stack);
      return left(BookingFailure('Failed to create booking: $e'));
    }
  }

  Stream<List<Booking>> getBookingsStream({
    required String userId,
    required String role,
  }) {
    final String field = role == 'Client' ? 'parentId' : 'babysitterId';

    return _firestore
        .collection('bookings')
        .where(field, isEqualTo: userId)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Booking.fromJson(
                    <String, dynamic>{...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<Either<BookingFailure, Unit>> updateBookingStatus({
    required String bookingId,
    String? status,
    String? paymentStatus,
    String? paymentMethod,
  }) async {
    try {
      final Map<String, dynamic> updates = <String, dynamic>{
        'updatedAt': DateTime.now().toIso8601String(),
      };

      if (status != null) updates['status'] = status;
      if (paymentStatus != null) updates['paymentStatus'] = paymentStatus;
      if (paymentMethod != null) updates['paymentMethod'] = paymentMethod;

      await _firestore.collection('bookings').doc(bookingId).update(updates);

      return right(unit);
    } catch (e, stack) {
      _logger.error('Failed to update booking status', e, stack);
      return left(BookingFailure('Failed to update booking status: $e'));
    }
  }
}
