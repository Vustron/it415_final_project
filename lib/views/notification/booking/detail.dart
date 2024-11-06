import 'package:flutter/material.dart';


class BookingDetailNotification extends StatefulWidget {
  const BookingDetailNotification({super.key});

  @override
  State<BookingDetailNotification> createState() =>
      _BookingDetailNotificationState();
}

class _BookingDetailNotificationState extends State<BookingDetailNotification> {
  // Sample booking data
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
          children: [
            _buildInfoCard(
              title: 'Booking Summary',
              children: [
                _buildDetailRow('Children', children.toString()),
                _buildDetailRow('Date', '${date.toLocal()}'.split(' ')[0]),
                _buildDetailRow('Time', time),
                _buildDetailRow('Stay in', stayIn ? 'Yes' : 'No'),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Address Information',
              children: [
                _buildDetailRow('Address', address),
                _buildDetailRow('Details', details),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Divider(color: Colors.grey.shade300),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
