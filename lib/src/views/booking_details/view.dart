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
      if (currentUser?.role == 'Babysitter') {
        return CustomSelect<String>(
          value: booking?.status,
          items: const <String>['pending', 'accepted', 'rejected', 'completed'],
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    ).format(double.tryParse(booking?.totalCost ?? '0') ?? 0),
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
              if (booking?.status == 'pending') ...<Widget>[
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
                                  const CheckoutScreen(),
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
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
