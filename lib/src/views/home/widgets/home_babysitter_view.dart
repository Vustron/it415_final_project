import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class HomeBabysitterView extends HookConsumerWidget {
  const HomeBabysitterView({
    super.key,
    this.user,
  });

  final UserAccount? user;
  bool get isVerified =>
      user?.emailVerified != null && user?.validIdVerified != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggerService logger = ref.watch(loggerService);
    logger.info('Fetching ratings for user ID: ${user?.id}');
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<Rating>>(
              stream: ref
                  .watch(ratingControllerService.notifier)
                  .getRatingsStream(user?.id ?? ''),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Rating>> snapshot) {
                if (snapshot.hasError) {
                  logger.error('Error fetching ratings: ${snapshot.error}');
                  return babySitterHeader(
                    username: user?.name ?? '',
                    networkImage: user?.profileImg ?? '',
                    starRatings: '0.0',
                    location: user?.address ?? '',
                    onlineStatus: user?.onlineStatus ?? false,
                    isVerified: isVerified,
                  );
                }

                logger.info('Connection state: ${snapshot.connectionState}');
                logger.info('Has data: ${snapshot.hasData}');

                final List<Rating> ratings = snapshot.data ?? <Rating>[];

                logger.info('Ratings count: ${ratings.length}');
                logger.info(
                    'Raw ratings: ${ratings.map((Rating r) => r.rating).toList()}');

                if (ratings.isEmpty) {
                  return babySitterHeader(
                    username: user?.name ?? '',
                    networkImage: user?.profileImg ?? '',
                    starRatings: '0.0',
                    location: user?.address ?? '',
                    onlineStatus: user?.onlineStatus ?? false,
                    isVerified: isVerified,
                  );
                }

                double totalRating = 0;
                int validRatings = 0;

                for (final Rating rating in ratings) {
                  if (rating.rating != null) {
                    totalRating += rating.rating!;
                    validRatings++;
                  }
                }

                final double averageRating =
                    validRatings > 0 ? totalRating / validRatings : 0.0;

                logger.info('Average rating calculated: $averageRating');

                return babySitterHeader(
                  username: user?.name ?? '',
                  networkImage: user?.profileImg ?? '',
                  starRatings: averageRating.toStringAsFixed(1),
                  location: user?.address ?? '',
                  onlineStatus: user?.onlineStatus ?? false,
                  isVerified: isVerified,
                );
              },
            ),
            BabysitterStatsCard(user: user!),
            const TransactionChart(colorBar: GlobalStyles.primaryButtonColor),
            const SizedBox(height: 145),
          ],
        ),
      ),
    );
  }
}
