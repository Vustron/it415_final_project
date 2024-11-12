import 'package:flutter/material.dart';

import 'package:babysitterapp/views/settings.dart';

Widget helpSupportTab() {
  return const SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitle(title: 'Frequently Asked Questions'),
        SizedBox(height: 10),
        FAQTile(
          question: 'How do I create an account?',
          answer:
              'To create an account, click on the "Sign Up" button, fill in the required information, and submit the form. You will receive a confirmation email to verify your account.',
        ),
        FAQTile(
          question: 'Where can I find my bookings?',
          answer:
              'You can find your bookings in the "My Bookings" section of the app. This section lists all your current and past bookings.',
        ),
        FAQTile(
          question: 'How do I change my password?',
          answer:
              'To change your password, go to the "Settings" section, select "Change Password," and follow the instructions provided.',
        ),
        FAQTile(
          question: 'How do I know if my booking is confirmed?',
          answer:
              'You will receive a confirmation notification and an email once your booking is confirmed.',
        ),
        SizedBox(height: 20),
        SectionTitle(title: 'Support Contacts'),
        SizedBox(height: 10),
        SupportTile(
          icon: Icons.email,
          title: 'Email us at bsit4cit415@gmail.com',
        ),
        SizedBox(height: 10),
        SupportTile(
          icon: Icons.phone,
          title: 'Call us at +1 800 123 456',
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}
