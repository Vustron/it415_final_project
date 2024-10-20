// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/booking/appbar.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
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
