// utils
import 'package:babysitterapp/models/notificationuser.dart';
import 'package:babysitterapp/widgets/notification/list.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationUsers> notificationUsers = <NotificationUsers>[
    NotificationUsers(
      name: 'Jane Russel',
      messageText:
          'has sent a request to apply as your babysitter! Review the application and respond at your earliest convenience.',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      showButtons: true, // You decide when to show buttons
    ),
    NotificationUsers(
        name: 'BabyCare',
        messageText:
            'Good news! A babysitter nearby has a 4.9-star rating. Book now to ensure the best care for your child!',
        imageURL: 'assets/images/placeholder_logo.png',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1))),
    NotificationUsers(
        name: 'BabyCare',
        messageText:
            'Theres a babysitter nearby with a 4.5-star rating, offering her services for only 350 pesos per day. Dont miss out—book her now!',
        imageURL: 'assets/images/placeholder_logo.png',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2))),
    NotificationUsers(
        name: 'Krystina',
        messageText:
            'has just sent a request for a babysitter. Please review and respond promptly!',
        imageURL: 'assets/images/placeholder_logo.png',
        showButtons: true, // You decide when to show buttons
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: notificationUsers.length,
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (BuildContext context, int index) {
                  return NotificationList(
                    name: notificationUsers[index].name,
                    messageText: notificationUsers[index].messageText,
                    imageUrl: notificationUsers[index].imageURL,
                    time: notificationUsers[index].createdAt,
                    isMessageRead: index == 0 || index == 3,
                    showButtons: notificationUsers[index]
                        .showButtons, // Controlled by you
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
