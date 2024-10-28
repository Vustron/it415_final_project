import 'package:flutter/material.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  HelpSupportPageState createState() => HelpSupportPageState();
}

class HelpSupportPageState extends State<HelpSupportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _rating = 0;
  final double _starSize = 30.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help, Support & Feedback',
            style: TextStyle(fontSize: 20)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Help & Support'),
            Tab(text: 'Feedback'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildHelpSupportTab(),
          _buildFeedbackTab(),
        ],
      ),
    );
  }

  Widget _buildHelpSupportTab() {
    return const Padding(
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
    );
  }

  Widget _buildFeedbackTab() {
    return Padding(
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
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: _starSize,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
              );
            }),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
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
            ),
          ),
        ],
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
          style: const TextStyle(fontSize: 15),
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
          style: const TextStyle(fontSize: 15),
        ),
        onTap: () {
          // Action logic here
        },
      ),
    );
  }
}
