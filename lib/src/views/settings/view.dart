import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class SettingsView extends HookConsumerWidget with GlobalStyles {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final ValueNotifier<bool> isAccountExpanded = useState(false);

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
              const SettingsLabel(title: 'GENERAL'),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction History',
                onTap: () {
                  CustomRouter.navigateToWithTransition(
                    const TransactionHistoryView(),
                    'rightToLeftWithFade',
                  );
                },
                style: optionTextStyle,
              ),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.help_outline,
                text: 'Help & Support',
                onTap: () {
                  CustomRouter.navigateToWithTransition(
                    const HelpSupportView(),
                    'rightToLeftWithFade',
                  );
                },
                style: optionTextStyle,
              ),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.notifications,
                text: 'Notification Preference',
                onTap: () {
                  CustomRouter.navigateToWithTransition(
                    const NotificationPreference(),
                    'rightToLeftWithFade',
                  );
                },
                style: optionTextStyle,
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
}
