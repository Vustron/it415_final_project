// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/widgets/booking/appbar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookingAppBar(),
      body: const Center(
        child: Text('Booking Screen'),
      ),
    );
  }
}
