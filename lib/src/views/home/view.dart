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
    final AuthState authState = ref.watch(authControllerService);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: authState.user?.role == 'Client'
            ? homeViewTitle(authState.user)
            : const Text('Dashboard', style: TextStyle(fontSize: 30)),
        actions: <Widget>[
          if (authState.user?.role == 'Client')
            IconButton(
              onPressed: () => CustomRouter.navigateToWithTransition(
                const BookingView(),
                'rightToLeftWithFade',
              ),
              icon: const Icon(
                FluentIcons.person_add_16_regular,
                color: Colors.black,
                size: 31,
              ),
            ),
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
      body: authState.user == null
          ? const Center(
              child: CircularProgressIndicator(
                color: GlobalStyles.primaryButtonColor,
              ),
            )
          : authState.user!.role == 'Client'
              ? HomeClientView(
                  authController: authController,
                  primaryButtonColor: GlobalStyles.primaryButtonColor,
                )
              : HomeBabysitterView(user: authState.user),
    );
  }
}
