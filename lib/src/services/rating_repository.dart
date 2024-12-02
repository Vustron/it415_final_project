import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class RatingFailure {
  RatingFailure(this.message);
  final String message;
}

class RatingRepository {
  RatingRepository({
    required FirebaseFirestore firestore,
    required LoggerService logger,
  })  : _firestore = firestore,
        _logger = logger;

  final FirebaseFirestore _firestore;
  final LoggerService _logger;

  Future<Either<RatingFailure, Rating>> createRating(Rating rating) async {
    try {
      _logger.info('Creating rating for babysitter: ${rating.babysitterId}');

      final String id = NanoIdGenerator.generate();
      final Map<String, dynamic> data = <String, dynamic>{
        ...rating.toJson(),
        'id': id,
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _firestore.collection('ratings').doc(id).set(data);
      return right(Rating.fromJson(data));
    } catch (e, stack) {
      _logger.error('Failed to create rating', e, stack);
      return left(RatingFailure('Failed to create rating: $e'));
    }
  }

  Stream<List<Rating>> getRatingsStream(String babysitterId) {
    _logger.info('Repository querying ratings for babysitter: $babysitterId');

    return _firestore
        .collection('ratings')
        .where('babysitterId', isEqualTo: babysitterId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      _logger.info('Got ${snapshot.docs.length} ratings from Firestore');
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Rating.fromJson(<String, dynamic>{...doc.data(), 'id': doc.id}))
          .toList();
    });
  }
}
