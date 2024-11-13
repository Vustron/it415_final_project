import 'package:babysitterapp/views/(home_Macas_Millan)/notification_babysitter/receipt/view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/components.dart';
import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/models/notification.dart';

import 'package:babysitterapp/views/home.dart';

class NotificationView extends HookConsumerWidget with GlobalStyles {
  NotificationView({super.key});

  final List<NotificationUsers> notificationUsers = <NotificationUsers>[
    NotificationUsers(
      name: 'Jane Russel',
      messageText:
          'has sent a request to apply as your babysitter! Review the application and respond at your earliest convenience.',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      showButtons: true,
      destinationScreen: BookingDetailNotification(),
    ),
    NotificationUsers(
      name: 'BabyCare',
      messageText:
          'Good news! A client has expressed satisfaction with your service and has successfully processed your payment. Thank you for your excellent work and dedication!',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      showButtons: true,
      destinationScreen: PaymentConfirmationScreen(),
    ),
    NotificationUsers(
      name: 'BabyCare',
      messageText:
          "There's a babysitter nearby with a 4.5-star rating, offering her services for only 350 pesos per day. Don't miss out—book her now!",
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    // NotificationUsers(
    //   name: 'Krystina',
    //   messageText:
    //       'has just sent a request for a babysitter. Please review and respond promptly!',
    //   imageURL: 'assets/images/hippo.png',
    //   createdAt: DateTime.now().subtract(const Duration(days: 3)),
    //   updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    //         showButtons: true,
    // ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextInput(
                onChanged: (String value) {},
                onClear: () {},
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: notificationUsers.length,
                padding: const EdgeInsets.symmetric(vertical: 17),
                itemBuilder: (BuildContext context, int index) {
                  final NotificationUsers user = notificationUsers[index];
                  return NotificationList(
                    name: user.name,
                    messageText: user.messageText,
                    imageUrl: user.imageURL,
                    time: user.createdAt,
                    isMessageRead: index == 0 || index == 3,
                    showButtons: user.showButtons,
                    destinationScreen: user.destinationScreen ??
                        Container(), // Provide default widget if null
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
