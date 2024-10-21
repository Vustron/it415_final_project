import 'package:flutter/material.dart';

import 'package:babysitterapp/core/widgets/settings/option_card.dart';
import 'package:babysitterapp/core/widgets/settings/option_tile.dart';
import 'package:babysitterapp/core/widgets/settings/personal_info.dart';

import 'package:babysitterapp/core/constants/assets.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Track which sections are expanded
  bool isAccountExpanded = false;
  bool isNotificationsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(avatar2),
                      radius: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Arvin Sison',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'arvinsison@gmail.com',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              const SectionTitle(title: 'GENERAL'),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.person,
                text: 'Personal Info',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<PersonalInfoPage>(
                      builder: (BuildContext context) => const PersonalInfoPage()
                    ),
                  );
                  
                },
              ),
              
              SettingsOptionCard(
                icon: Icons.notifications,
                text: 'Notifications',
                onTap: () {
                  setState(() {
                    isNotificationsExpanded =
                        !isNotificationsExpanded; // Toggle expansion
                  });
                },
                showDropdownIcon: true, // Show dropdown icon
                isExpanded: isNotificationsExpanded, // Pass the expanded state
              ),
              // if (isNotificationsExpanded) ...[
              //   ListTile(
              //     title: const Text('Push Notifications'),
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => NotificationsPage()),
              //       );
              //     },
              //   ),
              // ],
              SettingsOptionCard(
                icon: Icons.help_outline,
                text: 'Help & Support',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HelpSupportPage()),
                  // );
                },
              ),
              const SizedBox(height: 24),
              const SectionTitle(title: 'ACTIONS'),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction List',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TransactionListPage()),
                  // );
                },
              ),
              SettingsOptionCard(
                icon: Icons.feedback_outlined,
                text: 'Feedback',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FeedbackPage()),
                  // );
                },
              ),

              const SizedBox(height: 20, width: 20),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Log out',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade300,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
