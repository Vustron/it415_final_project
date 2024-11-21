import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class AccountView extends HookConsumerWidget with GlobalStyles {
  AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Account'),
      ),
      body: authState.user == null
          ? const Center(
              child: CircularProgressIndicator(
                color: GlobalStyles.primaryButtonColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 18),
                    AccountImageEditButton(user: authState.user!),
                    const SizedBox(height: 30),
                    Text(
                      authState.user!.description != null &&
                              authState.user!.description!.isNotEmpty
                          ? authState.user!.description!
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
                    Contacts(user: authState.user!),
                    const SizedBox(height: 130),
                  ],
                ),
              ),
            ),
    );
  }
}
