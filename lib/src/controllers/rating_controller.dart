import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class RatingController extends StateNotifier<RatingState> {
  RatingController(this.ratingRepo) : super(RatingState());

  final RatingRepository ratingRepo;

  Future<void> createRating({
    required String parentId,
    required String babysitterId,
    required double rating,
    String? comment,
  }) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    try {
      final Rating newRating = Rating(
        parentId: parentId,
        babysitterId: babysitterId,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
      );

      final Either<RatingFailure, Rating> result =
          await ratingRepo.createRating(newRating);

      result.fold(
        (RatingFailure failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
        (Rating rating) => state = state.copyWith(
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

  Stream<List<Rating>> getRatingsForBooking({
    required String parentId,
    required String babysitterId,
  }) {
    return ratingRepo.getRatingsStream(babysitterId).map(
        (List<Rating> ratings) => ratings
            .where((Rating rating) => rating.parentId == parentId)
            .toList());
  }
}
