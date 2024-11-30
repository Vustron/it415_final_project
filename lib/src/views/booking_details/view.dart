import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';
import 'package:latlong2/latlong.dart';

class BookingDetailsView extends HookConsumerWidget {
  const BookingDetailsView({
    super.key,
    this.booking,
  });

  final Booking? booking;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<double> buttonScale = useState(1.0);

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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _getStatusColor(booking?.status ?? '').withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking?.status.toUpperCase() ?? '',
                  style: TextStyle(
                    color: _getStatusColor(booking?.status ?? ''),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                  const Divider(height: 32),
                  dataDetails(
                    icon: FluentIcons.calendar_clock_24_regular,
                    label: 'Created',
                    value: DateFormat('MMM dd, yyyy HH:mm')
                        .format(booking?.createdAt ?? DateTime.now()),
                  ),
                  if (booking?.updatedAt != booking?.createdAt)
                    dataDetails(
                      icon: FluentIcons.history_24_regular,
                      label: 'Last Updated',
                      value: DateFormat('MMM dd, yyyy HH:mm')
                          .format(booking?.updatedAt ?? DateTime.now()),
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
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity, // Makes button take full width
                      child: MouseRegion(
                        onEnter: (_) => buttonScale.value = 0.98,
                        onExit: (_) => buttonScale.value = 1.0,
                        child: AnimatedScale(
                          scale: buttonScale.value,
                          duration: const Duration(milliseconds: 150),
                          child: OutlinedButton.icon(
                            onPressed: () {
                              final double lat =
                                  double.tryParse(booking!.addressLatitude) ??
                                      0;
                              final double lon =
                                  double.tryParse(booking!.addressLongitude) ??
                                      0;

                              CustomRouter.navigateToWithTransition(
                                MapScreen(
                                  initialLocation: LatLng(lat, lon),
                                  isReadOnly: true,
                                ),
                                'fade',
                              );
                            },
                            icon: const Icon(
                              FluentIcons.map_24_regular,
                              size: 20,
                            ),
                            label: const Text('View on Map'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              side: BorderSide(
                                color: GlobalStyles.primaryButtonColor
                                    .withOpacity(0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
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
