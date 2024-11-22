import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class NotificationView extends HookConsumerWidget with GlobalStyles {
  NotificationView({super.key});

  final List<NotificationUsers> notificationUsers = <NotificationUsers>[
    NotificationUsers(
      name: 'Jane Russel',
      messageText:
          'has sent a request for your service as a babysitter! Review the application and respond at your earliest convenience.',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      showButtons: true,
      destinationScreen: BookingDetailsView(),
    ),
    NotificationUsers(
      name: 'BabyCare',
      messageText:
          'Good news! A client has expressed satisfaction with your service and has successfully processed your payment. Thank you for your excellent work and dedication!',
      imageURL: logo,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      showButtons: true,
      destinationScreen: PaymentConfirmationView(),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<String> searchQuery = useState('');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextInput(
                onChanged: (String value) => searchQuery.value = value,
                onClear: () => searchQuery.value = '',
                prefixIcon: Icon(
                  FluentIcons.search_24_regular,
                  color: Colors.grey[600],
                ),
                hintText: 'Search notifications...',
                fieldLabel: 'Search',
                textInputAction: TextInputAction.search,
                fillColor: Colors.white,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notificationUsers.length,
                padding: const EdgeInsets.only(bottom: 16),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final NotificationUsers user = notificationUsers[index];
                  return NotificationList(
                    name: user.name,
                    messageText: user.messageText,
                    imageUrl: user.imageURL,
                    time: user.createdAt,
                    isMessageRead: index == 0 || index == 3,
                    showButtons: user.showButtons,
                    destinationScreen: user.destinationScreen ?? Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
