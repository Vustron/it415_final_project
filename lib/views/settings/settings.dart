import 'package:babysitterapp/core/widgets/settings/logout_button.dart';
import 'package:babysitterapp/views/settings/transaction_history.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/views/settings/personal_info_page.dart';

import 'package:babysitterapp/views/settings/feedback_page.dart';
import 'package:babysitterapp/views/settings/help_support_page.dart';

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
              const core.SectionTitle(title: 'GENERAL'), // Use core prefix
              const SizedBox(height: 8),
              _buildOptionCard(
                icon: Icons.person,
                text: 'Personal Information',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const PersonalInfoPage(),
                    ),
                  );
                },
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
              const core.SectionTitle(title: 'ACTIONS'),
              const SizedBox(height: 8),
              _buildOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction History',
                onTap: () {
                  Navigator.push<dynamic>(
                    context, 
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => TransactionHistoryPage(),
                    ),
                  );
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
              LogoutButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // User profile widget
  

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

  
}
