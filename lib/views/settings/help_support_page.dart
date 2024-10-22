import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontSize: 20), // Added font size
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(title: 'Frequently Asked Questions'),
            SizedBox(height: 10),
            FAQTile(question: 'How do I create an account?'),
            FAQTile(question: 'Where can I find my bookings?'),
            FAQTile(question: 'How do I change my password?'),
            FAQTile(question: 'How do I know if my booking is confirmed?'),
            SizedBox(height: 20),
            SectionTitle(title: 'Support Contacts'),
            SizedBox(height: 10),
            SupportTile(
              icon: Icons.email,
              title: 'Email us at support@babysitterapp.com',
            ),
            SizedBox(height: 10),
            SupportTile(
              icon: Icons.phone,
              title: 'Call us at +1 800 123 456',
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for section titles
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Custom widget for FAQ items
class FAQTile extends StatelessWidget {
  const FAQTile({super.key, required this.question});
  final String question;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 15), // Added font size
        ),
        trailing: const Icon(Icons.keyboard_arrow_down),
        onTap: () {
          // Expand or show answer logic here
        },
      ),
    );
  }
}

// Custom widget for support contacts
class SupportTile extends StatelessWidget {
  const SupportTile({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15), // Added font size
        ),
        onTap: () {
          // Action logic here
        },
      ),
    );
  }
}
