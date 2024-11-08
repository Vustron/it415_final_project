import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/authentication_controller.dart';
import 'package:babysitterapp/core/helper/check_user.dart';
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'widgets/notification_preference.dart';
import '../transaction_history/view.dart';
import 'widgets/option_tile.dart' as core;
import 'widgets/logout_button.dart';
import '../help_support/view.dart';
import 'widgets/option_card.dart';

class SettingsView extends HookConsumerWidget with GlobalStyles {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authController);

    useEffect(() {
      checkUserAndRedirect(context, ref);
      return null;
    }, <Object?>[]);

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
              const core.SectionTitle(title: 'GENERAL'),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.list_alt,
                text: 'Transaction History',
                onTap: () {
                  goToPage(context, const TransactionHistoryView(),
                      'rightToLeftWithFade');
                },
                style: optionTextStyle,
              ),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.help_outline,
                text: 'Help & Support',
                onTap: () {
                  goToPage(
                      context, const HelpSupportPage(), 'rightToLeftWithFade');
                },
                style: optionTextStyle,
              ),
              const SizedBox(height: 8),
              SettingsOptionCard(
                icon: Icons.notifications,
                text: 'Notification Preference',
                onTap: () {
                  goToPage(context, const NotificationPreference(),
                      'rightToLeftWithFade');
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
