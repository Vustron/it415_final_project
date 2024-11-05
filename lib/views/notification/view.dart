// core
import 'package:babysitterapp/core/components/input.dart';

// flutter
import 'package:flutter/material.dart';

// models
import 'package:babysitterapp/models/notification.dart';

// widgets
import 'widgets/list.dart';

// styles


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final List<NotificationUsers> notificationUsers = <NotificationUsers>[
    NotificationUsers(
      name: 'Jane Russel',
      messageText: 'has sent a request to apply as your babysitter! Review the application and respond at your earliest convenience.',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      showButtons: true,
    ),
    NotificationUsers(
      name: 'BabyCare',
      messageText: 'Good news! A babysitter nearby has a 4.9-star rating. Book now to ensure the best care for your child!',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    NotificationUsers(
      name: 'BabyCare',
      messageText: "There's a babysitter nearby with a 4.5-star rating, offering her services for only 350 pesos per day. Don't miss out—book her now!",
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    NotificationUsers(
      name: 'Krystina',
      messageText: 'has just sent a request for a babysitter. Please review and respond promptly!',
      imageURL: 'assets/images/hippo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      showButtons: true,
    ),
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification')),
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
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (BuildContext context, int index) {
                  final NotificationUsers user = notificationUsers[index];
                  return NotificationList(
                    name: user.name,
                    messageText: user.messageText,
                    imageUrl: user.imageURL,
                    time: user.createdAt,
                    isMessageRead: index == 0 || index == 3,
                    showButtons: user.showButtons,
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