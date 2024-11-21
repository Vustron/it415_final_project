import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            infoCard(
              title: 'Booking Summary',
              children: <Widget>[
                cardDetails('Children', children.toString()),
                cardDetails('Date', '${date.toLocal()}'.split(' ')[0]),
                cardDetails('Time', time),
                cardDetails('Stay in', stayIn ? 'Yes' : 'No'),
                const SizedBox(height: 16),
                Text(
                  'Total Amount: $amount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            infoCard(
              title: 'Address Information',
              children: <Widget>[
                cardDetails('Address', address),
                cardDetails('Details', details),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final bool? confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Booking'),
                      content: const Text(
                          'Are you sure you want to confirm this booking?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            CustomRouter.navigateToWithTransition(
                              const CheckoutScreen(),
                              'fade',
                            );
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    );
                  },
                );

                if (confirm ?? false) {
                  if (!context.mounted) {
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking Confirmed'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  if (!context.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking Canceled'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: GlobalStyles.primaryButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}