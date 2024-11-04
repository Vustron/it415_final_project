// utils
import 'package:babysitterapp/core/components/input.dart';
import 'package:flutter/material.dart';

// models
import 'package:babysitterapp/models/chatuser.dart';

// widgets
import 'package:babysitterapp/views/message/widgets/list.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageView> {
  List<ChatUsers> chatUsers = <ChatUsers>[
    ChatUsers(
      name: 'Jane Russel',
      messageText: 'Awesome Setup',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ChatUsers(
      name: "Glady's Murphy",
      messageText: "That's Great",
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ChatUsers(
      name: 'Jorge Henry',
      messageText: 'Hey where are you?',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ChatUsers(
      name: 'Philip Fox',
      messageText: 'Busy! Call me in 20 mins',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ChatUsers(
      name: 'Debra Hawkins',
      messageText: "Thank you, It's awesome",
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    ChatUsers(
      name: 'Jacob Pena',
      messageText: 'Will update you in the evening',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ChatUsers(
      name: 'Andrew Jones',
      messageText: 'Can you please share the file?',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    ChatUsers(
      name: 'John Wick',
      messageText: 'How are you?',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Conversations',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Add New',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextInput(
                onChanged: (String value) {},
                onClear: () {},
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: chatUsers.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (BuildContext context, int index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].createdAt,
                    isMessageRead: index == 0 || index == 3,
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
