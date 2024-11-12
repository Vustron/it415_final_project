import 'package:flutter/material.dart';

Widget feedbackTab(ValueNotifier<double> rating, double starSize) {
  return SingleChildScrollView(
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
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            labelText: 'Your feedback',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Rate us:',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(5, (int index) {
            return IconButton(
              icon: Icon(
                index < rating.value ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: starSize,
              ),
              onPressed: () {
                rating.value = index + 1;
              },
            );
          }),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Submit feedback logic
            },
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    ),
  );
}
