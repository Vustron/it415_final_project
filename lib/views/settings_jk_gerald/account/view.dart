import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/models.dart';

import 'package:babysitterapp/views/settings.dart';

class AccountView extends HookConsumerWidget with GlobalStyles {
  AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthenticationState authState = ref.watch(authController);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Account'),
      ),
      body: authState.maybeWhen(
        authenticated: (UserAccount user) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 18),
                AccountImageEditButton(user: user),
                const SizedBox(height: 30),
                Text(
                  user.description != null && user.description!.isNotEmpty
                      ? user.description!
                      : 'No description yet',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 30),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 12),
                const Ratings(),
                const SizedBox(height: 12),
                const Divider(color: Colors.grey, thickness: 1),
                const ServiceHistoryUpload(),
                const Divider(color: Colors.grey, thickness: 1),
                const ValidIdUpload(),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 12),
                Contacts(user: user),
                const SizedBox(height: 130),
              ],
            ),
          ),
        ),
        orElse: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
