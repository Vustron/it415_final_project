// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

// widgets
import 'widgets/option_tile.dart' as core;
import 'widgets/logout_button.dart';
import 'widgets/help_support.dart';
import 'widgets/option_card.dart';
import 'widgets/transaction_history.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with GlobalStyles {
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
              const core.SectionTitle(title: 'GENERAL'),
              // _buildOptionCard(
              //   icon: Icons.person,
              //   text: 'Personal Information',
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute<dynamic>(
              //         builder: (BuildContext context) => const PersonalInformation(),
              //       ),
              //     );
              //   },
              // ),

              const SizedBox(height: 8),

              _buildOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction History',
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const TransactionHistory(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 8),

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

              const SizedBox(height: 8),
              _buildOptionCard(
                icon: Icons.notifications,
                text: 'Notification Preference',
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const TransactionHistory(),
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
      style: optionTextStyle,
    );
  }
}
