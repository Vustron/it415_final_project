import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants/styles.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class BookingDetailsView extends HookConsumerWidget with GlobalStyles {
  BookingDetailsView({super.key});

  final int children = 5;
  final DateTime date = DateTime.parse('2024-11-11');
  final String time = '12:15 AM - 4:20 AM';
  final bool stayIn = true;
  final String address = 'Home';
  final String details = 'Bring Your ID';
  final String amount = '₱11k';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<double> buttonScale = useState(1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Confirmation',
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              dataCard(
                title: 'Booking Summary',
                icon: FluentIcons.calendar_ltr_24_filled,
                children: <Widget>[
                  dataDetails(
                    icon: FluentIcons.people_24_regular,
                    label: 'Children',
                    value: children.toString(),
                  ),
                  dataDetails(
                    icon: FluentIcons.calendar_24_regular,
                    label: 'Date',
                    value: '${date.toLocal()}'.split(' ')[0],
                  ),
                  dataDetails(
                    icon: FluentIcons.clock_24_regular,
                    label: 'Time',
                    value: time,
                  ),
                  dataDetails(
                    icon: FluentIcons.home_24_regular,
                    label: 'Stay in',
                    value: stayIn ? 'Yes' : 'No',
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        amount,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: GlobalStyles.primaryButtonColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              dataCard(
                title: 'Address Information',
                icon: FluentIcons.location_24_filled,
                children: <Widget>[
                  dataDetails(
                    icon: FluentIcons.map_24_regular,
                    label: 'Address',
                    value: address,
                  ),
                  dataDetails(
                    icon: FluentIcons.info_24_regular,
                    label: 'Details',
                    value: details,
                  ),
                ],
              ),
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
                          isLoading.value ? 'Processing...' : 'Confirm Booking',
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
          ),
        ),
      ),
    );
  }
}
