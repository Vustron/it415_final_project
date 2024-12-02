import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class BabysitterStatsCard extends HookConsumerWidget {
  const BabysitterStatsCard({
    super.key,
    required this.user,
  });

  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Booking>>(
      stream:
          ref.watch(bookingControllerService.notifier).getBookingsStream(user),
      builder: (BuildContext context, AsyncSnapshot<List<Booking>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<Booking> bookings = snapshot.data ?? <Booking>[];

        final int completedTransactions = bookings
            .where((Booking booking) =>
                booking.status == 'completed' &&
                booking.paymentStatus == 'completed')
            .length;

        final int totalBabysitted = bookings.length;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: statsCard(
                  icon: FluentIcons.money_24_regular,
                  value: completedTransactions.toString(),
                  label: 'No. of transaction',
                  iconColor: Colors.green.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: statsCard(
                  icon: FluentIcons.person_24_regular,
                  value: totalBabysitted.toString(),
                  label: 'No. of Babysitted',
                  iconColor: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
