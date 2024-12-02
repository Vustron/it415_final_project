import 'package:babysitterapp/src/models.dart';

class RatingState {
  RatingState({
    this.ratings = const <Rating>[],
    this.isLoading = false,
    this.error,
  });

  final List<Rating> ratings;
  final bool isLoading;
  final String? error;

  RatingState copyWith({
    List<Rating>? ratings,
    bool? isLoading,
    String? error,
  }) {
    return RatingState(
      ratings: ratings ?? this.ratings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
