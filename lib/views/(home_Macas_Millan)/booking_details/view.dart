import 'package:flutter/material.dart';

import 'widgets/card_details.dart';
import 'widgets/info_card.dart';

class BookingDetailNotification extends StatefulWidget {
  const BookingDetailNotification({super.key});

  @override
  State<BookingDetailNotification> createState() =>
      _BookingDetailNotificationState();
}

class _BookingDetailNotificationState extends State<BookingDetailNotification> {
  final int children = 5;
  final DateTime date = DateTime.parse('2024-11-11');
  final String time = '12:15 AM - 4:20 AM';
  final bool stayIn = true;
  final String address = 'Home';
  final String details = 'Bring Your ID';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
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
          ],
        ),
      ),
    );
  }
}
