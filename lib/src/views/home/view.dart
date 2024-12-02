import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class HomeView extends HookConsumerWidget with GlobalStyles {
  HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthController authController =
        ref.watch(authControllerService.notifier);
    final AuthState currentUser = ref.watch(authControllerService);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: currentUser.user?.role == 'Client'
            ? homeViewTitle(currentUser.user)
            : const Text('Dashboard', style: TextStyle(fontSize: 30)),
        actions: <Widget>[
          if (currentUser.user?.role == 'Client')
            IconButton(
              onPressed: () => CustomRouter.navigateToWithTransition(
                SettingsView(),
                'rightToLeftWithFade',
              ),
              icon: const Icon(
                FluentIcons.settings_16_filled,
                color: Colors.black,
                size: 31,
              ),
            )
        ],
      ),
      backgroundColor: Colors.white,
      body: currentUser.user == null
          ? const Center(
              child: CircularProgressIndicator(
                color: GlobalStyles.primaryButtonColor,
              ),
            )
          : currentUser.user!.role == 'Client'
              ? VerificationGuard(
                  user: currentUser.user,
                  child: HomeClientView(
                    authController: authController,
                    primaryButtonColor: GlobalStyles.primaryButtonColor,
                  ),
                )
              : VerificationGuard(
                  user: currentUser.user,
                  child: HomeBabysitterView(
                    user: currentUser.user,
                  ),
                ),
    );
  }
}
