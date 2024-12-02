import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class NotificationView extends HookConsumerWidget {
  const NotificationView({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'ongoing':
        return Colors.yellow;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusMessage(String status, bool isParent) {
    switch (status.toLowerCase()) {
      case 'pending':
        return isParent
            ? 'Waiting for babysitter response'
            : 'New booking request! Please review.';
      case 'accepted':
        return isParent
            ? 'Booking confirmed! The babysitter accepted.'
            : 'You accepted this booking.';
      case 'ongoing':
        return isParent
            ? 'Babysitter is currently working'
            : 'You are currently working.';
      case 'rejected':
        return isParent
            ? 'Booking declined by babysitter'
            : 'You declined this booking.';
      case 'completed':
        return 'Booking completed';
      default:
        return 'Status unknown';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<String> searchQuery = useState('');
    final UserAccount? currentUser = ref.watch(authControllerService).user;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please login to view notifications'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: VerificationGuard(
        user: currentUser,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomTextInput(
                  onChanged: (String value) => searchQuery.value = value,
                  onClear: () => searchQuery.value = '',
                  prefixIcon: Icon(
                    FluentIcons.search_24_regular,
                    color: Colors.grey[600],
                  ),
                  hintText: 'Search notifications...',
                  fieldLabel: 'Search notifications...',
                  textInputAction: TextInputAction.search,
                  fillColor: Colors.white,
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Booking>>(
                  stream: ref
                      .watch(bookingControllerService.notifier)
                      .getBookingsStream(currentUser),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Booking>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: GlobalStyles.primaryButtonColor,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    final List<Booking> bookings = snapshot.data ?? <Booking>[];

                    if (bookings.isEmpty) {
                      return const Center(
                        child: Text('No notifications found'),
                      );
                    }

                    final List<Booking> filteredBookings = bookings
                        .where((Booking booking) => booking
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery.value.toLowerCase()))
                        .toList();

                    return ListView.builder(
                      itemCount: filteredBookings.length,
                      padding: const EdgeInsets.only(bottom: 16),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final Booking booking = filteredBookings[index];
                        final bool isParent = currentUser.role == 'Client';

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                CustomRouter.navigateToWithTransition(
                                  BookingDetailsView(booking: booking),
                                  'rightToLeftWithFade',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          DateFormat('MMM dd, yyyy')
                                              .format(booking.workingDate),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                _getStatusColor(booking.status)
                                                    .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            booking.status.toUpperCase(),
                                            style: TextStyle(
                                              color: _getStatusColor(
                                                  booking.status),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FluentIcons.clock_24_regular,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${booking.startTime} - ${booking.endTime}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FluentIcons.location_24_regular,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            booking.address,
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FluentIcons.people_24_regular,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${booking.numberOfChildren} children',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _getStatusMessage(
                                          booking.status, isParent),
                                      style: TextStyle(
                                        color: _getStatusColor(booking.status),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
