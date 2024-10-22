// ignore_for_file: library_private_types_in_public_api, always_specify_types

import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 0; // Store the selected rating
  final double _starSize = 30.0; // Adjustable size for stars

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'We value your feedback!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your feedback',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            // Star Rating Section
            const Text(
              'Rate us:',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (int index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: _starSize, // Set the star size
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1; // Update rating
                    });
                  },
                );
              }),
            ),
            // Using Expanded to stretch the button across the width
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle feedback submission
                      // You can access _rating to get the rating value
                      // and implement your submission logic here
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
