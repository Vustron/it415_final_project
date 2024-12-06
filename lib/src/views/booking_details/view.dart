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

class BookingDetailsView extends HookConsumerWidget {
  const BookingDetailsView({
    super.key,
    this.booking,
  });

  final Booking? booking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<double> buttonScale = useState(1.0);
    final UserAccount? currentUser = ref.watch(authControllerService).user;
    final Toast toast = ref.watch(toastService);

    Future<void> handleRefresh() async {
      try {
        await ref
            .read(bookingControllerService.notifier)
            .getBooking(booking?.id ?? '');

        await Future<void>.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Error',
            message: 'Failed to refresh: $e',
            type: 'error',
          );
        }
      }
    }

    Future<void> handleStatusUpdate(String newStatus) async {
      try {
        isLoading.value = true;
        await ref.read(bookingControllerService.notifier).updateBookingStatus(
              bookingId: booking?.id ?? '',
              status: newStatus,
            );
        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Success',
            message: 'Booking status updated successfully',
            type: 'success',
          );
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (context.mounted) {
          toast.show(
            context: context,
            title: 'Error',
            message: 'Failed to update booking status: $e',
            type: 'error',
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    Widget buildStatusBadge() {
      if (booking?.status == 'completed') {
        return StatusBadge(
          status: booking?.status ?? '',
        );
      }

      if (currentUser?.role == 'Babysitter') {
        return CustomSelect<String>(
          value: booking?.status,
          items: const <String>[
            'pending',
            'accepted',
            'ongoing',
            'rejected',
            'completed'
          ],
          onChanged: (String? value) {
            if (value != null && value != booking?.status) {
              handleStatusUpdate(value);
            }
          },
          borderRadius: 12,
          isDense: true,
          isRequired: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              FluentIcons.clock_24_filled,
              color: getStatusColor(booking?.status ?? ''),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: getStatusColor(booking?.status ?? '').withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: getStatusColor(booking?.status ?? '').withOpacity(0.3),
              ),
            ),
          ),
          style: TextStyle(
            color: getStatusColor(booking?.status ?? ''),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        );
      }

      return StatusBadge(
        status: booking?.status ?? '',
      );
    }

    Widget buildPaymentSection() {
      return dataCard(
        title: 'Payment Details',
        icon: FluentIcons.payment_24_filled,
        children: <Widget>[
          dataDetails(
            icon: FluentIcons.money_24_regular,
            label: 'Payment Status',
            value: booking?.paymentStatus.toUpperCase() ?? 'PENDING',
          ),
          if (booking?.paymentMethod != null)
            dataDetails(
              icon: FluentIcons.wallet_24_regular,
              label: 'Payment Method',
              value: booking?.paymentMethod?.toUpperCase() ?? '-',
            ),
          dataDetails(
            icon: FluentIcons.money_hand_24_regular,
            label: 'Total Amount',
            value: NumberFormat.currency(
              symbol: '₱',
              decimalDigits: 2,
            ).format(double.tryParse(booking?.totalCost ?? '0') ?? 0),
          ),
        ],
      );
    }

    Future<void> showRatingBottomSheet(BuildContext context) async {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => RatingBottomSheet(
          onSubmit: (double rating, String comment) async {
            try {
              await ref.read(ratingControllerService.notifier).createRating(
                    parentId: currentUser?.id ?? '',
                    babysitterId: booking?.babysitterId ?? '',
                    bookingId: booking?.id ?? '',
                    rating: rating,
                    comment: comment,
                  );

              if (context.mounted) {
                Navigator.pop(context);
                toast.show(
                  context: context,
                  title: 'Success',
                  message: 'Rating submitted successfully',
                  type: 'success',
                );
              }
            } catch (e) {
              if (context.mounted) {
                toast.show(
                  context: context,
                  title: 'Error',
                  message: 'Failed to submit rating: $e',
                  type: 'error',
                );
              }
            }
          },
        ),
      );
    }

    Widget buildRatingSection() {
      if (booking?.status != 'completed' || currentUser?.role != 'Client') {
        return const SizedBox.shrink();
      }

      return StreamBuilder<List<Rating>>(
        stream:
            ref.watch(ratingControllerService.notifier).getRatingsForBooking(
                  parentId: currentUser?.id ?? '',
                  babysitterId: booking?.babysitterId ?? '',
                  bookingId: booking?.id ?? '',
                ),
        builder: (BuildContext context, AsyncSnapshot<List<Rating>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final bool hasRated = snapshot.hasData && snapshot.data!.isNotEmpty;
          final Rating? userRating = hasRated ? snapshot.data!.first : null;

          return Column(
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: hasRated
                        ? <Color>[Colors.green.withOpacity(0.1), Colors.white]
                        : <Color>[Colors.amber.withOpacity(0.1), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasRated
                        ? Colors.green.withOpacity(0.3)
                        : Colors.amber.withOpacity(0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: hasRated
                        ? <Widget>[
                            const Row(
                              children: <Widget>[
                                Icon(
                                  FluentIcons.checkmark_circle_24_filled,
                                  color: Colors.green,
                                  size: 28,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'You have already rated',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: <Widget>[
                                ...List<Widget>.generate(
                                  5,
                                  (int index) => Icon(
                                    index < (userRating!.rating ?? 0).toInt()
                                        ? FluentIcons.star_24_filled
                                        : FluentIcons.star_24_regular,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${userRating!.rating}/5',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (userRating.comment != null &&
                                userRating.comment!.isNotEmpty) ...<Widget>[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Text(
                                      'Your Review',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      userRating.comment!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ]
                        : <Widget>[
                            // Existing "Add Rating" UI
                            const Row(
                              children: <Widget>[
                                Icon(
                                  FluentIcons.star_24_filled,
                                  color: Colors.amber,
                                  size: 28,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Rate Your Experience',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Share your feedback about the babysitting service to help other parents make informed decisions.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: MouseRegion(
                                onEnter: (_) => buttonScale.value = 0.98,
                                onExit: (_) => buttonScale.value = 1.0,
                                child: AnimatedScale(
                                  scale: buttonScale.value,
                                  duration: const Duration(milliseconds: 150),
                                  child: ElevatedButton.icon(
                                    onPressed: isLoading.value
                                        ? null
                                        : () async {
                                            await showRatingBottomSheet(
                                                context);
                                          },
                                    icon: const Icon(
                                      FluentIcons.star_add_24_filled,
                                      size: 20,
                                    ),
                                    label: const Text(
                                      'Add Your Rating',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      backgroundColor: Colors.amber,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        elevation: 0,
      ),
      body: VerificationGuard(
        user: currentUser,
        child: RefreshIndicator(
          onRefresh: handleRefresh,
          color: GlobalStyles.primaryButtonColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildStatusBadge(),
                  const SizedBox(height: 16),
                  dataCard(
                    title: 'Booking Summary',
                    icon: FluentIcons.calendar_ltr_24_filled,
                    children: <Widget>[
                      dataDetails(
                        icon: FluentIcons.people_24_regular,
                        label: 'Children',
                        value: booking?.numberOfChildren.toString() ?? '',
                      ),
                      dataDetails(
                        icon: FluentIcons.calendar_24_regular,
                        label: 'Date',
                        value: DateFormat('MMM dd, yyyy')
                            .format(booking?.workingDate ?? DateTime.now()),
                      ),
                      dataDetails(
                        icon: FluentIcons.clock_24_regular,
                        label: 'Time',
                        value:
                            '${booking?.startTime ?? ''} - ${booking?.endTime ?? ''}',
                      ),
                      dataDetails(
                        icon: FluentIcons.home_24_regular,
                        label: 'Stay in',
                        value: booking?.stayIn ?? true ? 'Yes' : 'No',
                      ),
                      const Divider(height: 32),
                      dataDetails(
                        icon: FluentIcons.money_24_regular,
                        label: 'Total Cost',
                        value: NumberFormat.currency(
                          symbol: '₱',
                          decimalDigits: 2,
                        ).format(
                            double.tryParse(booking?.totalCost ?? '0') ?? 0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  dataCard(
                    title: 'Location Details',
                    icon: FluentIcons.location_24_filled,
                    children: <Widget>[
                      dataDetails(
                        icon: FluentIcons.map_24_regular,
                        label: 'Address',
                        value: booking?.address ?? '',
                      ),
                      dataDetails(
                        icon: FluentIcons.location_24_regular,
                        label: 'Coordinates',
                        value:
                            '${booking?.addressLatitude ?? ''}, ${booking?.addressLongitude ?? ''}',
                      ),
                      if (booking?.addressLatitude != null &&
                          booking?.addressLongitude != null) ...<Widget>[
                        Divider(color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        LocationPreview(
                          latitude: double.parse(booking!.addressLatitude),
                          longitude: double.parse(booking!.addressLongitude),
                          hideTitle: true,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildPaymentSection(),
                  const SizedBox(height: 16),
                  dataCard(
                    title: 'Additional Information',
                    icon: FluentIcons.info_24_filled,
                    children: <Widget>[
                      dataDetails(
                        icon: FluentIcons.text_description_24_regular,
                        label: 'Details',
                        value: booking?.details ?? '',
                      ),
                    ],
                  ),
                  if (booking?.status == 'pending' &&
                      currentUser?.role == 'Client') ...<Widget>[
                    const SizedBox(height: 24),
                    MouseRegion(
                      onEnter: (_) => buttonScale.value = 0.98,
                      onExit: (_) => buttonScale.value = 1.0,
                      child: AnimatedScale(
                        scale: buttonScale.value,
                        duration: const Duration(milliseconds: 150),
                        child: ElevatedButton(
                          onPressed: isLoading.value
                              ? null
                              : () async {
                                  isLoading.value = true;
                                  final bool? confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        confirmationDialog(context),
                                  );
                                  isLoading.value = false;

                                  if (confirm ?? false) {
                                    if (!context.mounted) return;
                                    CustomRouter.navigateToWithTransition(
                                      CheckoutScreen(booking: booking),
                                      'fade',
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            backgroundColor: GlobalStyles.primaryButtonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (isLoading.value)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ),
                              Text(
                                isLoading.value
                                    ? 'Processing...'
                                    : 'Confirm Booking',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  buildRatingSection(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
