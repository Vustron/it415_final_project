import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/controllers/authentication_controller.dart';

import 'package:babysitterapp/core/helper/goto_page.dart';

import 'package:babysitterapp/models/user_account.dart';

import 'package:babysitterapp/views/(auth_Lara_Esco)/login/view.dart';

Future<void> checkUserAndRedirect(BuildContext context, WidgetRef ref) async {
  final Either<String, UserAccount> userResult =
      await ref.read(authController.notifier).getUser();
  userResult.fold(
    (String error) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Not Authenticated'),
            content: const Text('You are not authenticated, please login.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  goToPage(context, const LoginView(), 'rightToLeftWithFade');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    },
    (UserAccount user) {
      // User is authenticated, no action needed
    },
  );
}
