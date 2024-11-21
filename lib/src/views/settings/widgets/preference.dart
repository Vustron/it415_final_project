import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class NotificationPreference extends StatefulWidget {
  const NotificationPreference({super.key});

  @override
  State<NotificationPreference> createState() => _NotificationPreferenceState();
}

class _NotificationPreferenceState extends State<NotificationPreference> {
  bool _isEmailToggled = false;
  bool _isSMSToggled = false;

  void _toggleEmail() {
    setState(() {
      _isEmailToggled = !_isEmailToggled;
    });
  }

  void _toggleSMS() {
    setState(() {
      _isSMSToggled = !_isSMSToggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preference'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topLeft,
                child: SettingsLabel(title: 'GENERAL'),
              ),
              const SizedBox(height: 14),

              // Row for Email Notifications
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Receive email notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Important updates and alerts via email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _toggleEmail,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isEmailToggled
                            ? GlobalStyles.primaryButtonColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            left: _isEmailToggled ? 30 : 0,
                            top: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Receive SMS notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Updates directly to your phone via SMS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _toggleSMS,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isSMSToggled
                            ? GlobalStyles.primaryButtonColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            left: _isSMSToggled ? 30 : 0,
                            top: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
