import 'package:babysitterapp/core/state/authentication_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/authentication_controller.dart';
import 'package:babysitterapp/core/helper/check_user.dart';
import 'package:babysitterapp/models/user_account.dart';

import 'widgets/image_edit_button.dart';
import 'widgets/service_history.dart';
import 'widgets/contacts.dart';
import 'widgets/valid_id.dart';
import 'widgets/ratings.dart';

/* *
    
    TODO: either isagul ninyo tung service history ug transaction history or lahiun ninyo ang transaction history ug service history
    
* */

class AccountView extends HookConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthenticationState authState = ref.watch(authController);

    useEffect(() {
      checkUserAndRedirect(context, ref);
      return null;
    }, <Object?>[]);

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
                  user.description ?? 'No description yet',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
