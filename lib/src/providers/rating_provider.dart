import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

final Provider<RatingRepository> ratingService =
    Provider<RatingRepository>((ProviderRef<RatingRepository> ref) {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final LoggerService logger = ref.watch(loggerService);

  return RatingRepository(
    firestore: firestore,
    logger: logger,
  );
});

final StateNotifierProvider<RatingController, RatingState>
    ratingControllerService =
    StateNotifierProvider<RatingController, RatingState>(
        (StateNotifierProviderRef<RatingController, RatingState> ref) {
  final RatingRepository repository = ref.watch(ratingService);

  return RatingController(repository);
});
