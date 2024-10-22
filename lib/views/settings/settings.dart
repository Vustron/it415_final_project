import 'feedback_page.dart';
import 'help_support_page.dart';
import 'package:flutter/material.dart';
import 'package:babysitterapp/core/widgets/settings/option_card.dart';
import 'package:babysitterapp/core/widgets/settings/option_tile.dart' as core;

// Define a common text style
const TextStyle _optionTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool isAccountExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildUserProfile(),
              const core.SectionTitle(title: 'GENERAL'), // Use core prefix
              const SizedBox(height: 8),
              _buildOptionCard(
                icon: Icons.person,
                text: 'Account',
                onTap: () {
                  setState(() {
                    isAccountExpanded = !isAccountExpanded;
                  });
                },
                isExpanded: isAccountExpanded,
              ),
              _buildOptionCard(
                icon: Icons.help_outline,
                text: 'Help & Support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          const HelpSupportPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const core.SectionTitle(title: 'ACTIONS'), // Use core prefix
              const SizedBox(height: 8),
              _buildOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction List',
                onTap: () {
                  // Transaction page navigation
                },
              ),
              _buildOptionCard(
                icon: Icons.feedback_outlined,
                text: 'Feedback & Ratings',
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const FeedbackPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLogoutButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // User profile widget
  Widget _buildUserProfile() {
    return const Center(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/sid.png'),
            radius: 80,
          ),
          SizedBox(height: 10),
          Text(
            'Arvin Sison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'arvinsison@gmail.com',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Reusable option card widget
  Widget _buildOptionCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isExpanded = false,
  }) {
    return SettingsOptionCard(
      icon: icon,
      text: text,
      onTap: onTap,
      showDropdownIcon: text == 'Account',
      isExpanded: isExpanded,
      style: _optionTextStyle,
    );
  }

  // Logout button widget
  Widget _buildLogoutButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text('Log out', style: TextStyle(color: Colors.white)),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue.shade300,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
