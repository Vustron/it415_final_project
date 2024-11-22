import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class MessageView extends HookConsumerWidget with GlobalStyles {
  MessageView({super.key});

  final List<ChatUsers> chatUsers = <ChatUsers>[
    ChatUsers(
      name: 'Jane Russel',
      messageText: 'Awesome Setup',
      number: '0920333181',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    ChatUsers(
      name: "Glady's Murphy",
      messageText: "That's Great",
      number: '097569341398',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ChatUsers(
      name: 'Jorge Henry',
      messageText: 'Hey where are you?',
      number: '0930698568',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ChatUsers(
      name: 'Philip Fox',
      messageText: 'Busy! Call me in 20 mins',
      number: '09403994556',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ChatUsers(
      name: 'Debra Hawkins',
      messageText: "Thank you, It's awesome",
      number: '095058564852',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    ChatUsers(
      name: 'Jacob Pena',
      messageText: 'Will update you in the evening',
      number: '09905796152',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ChatUsers(
      name: 'Andrew Jones',
      messageText: 'Can you please share the file?',
      number: '09718693268',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    ChatUsers(
      name: 'John Wick',
      messageText: 'How are you?',
      number: '0940752757',
      imageURL: 'assets/images/placeholder_logo.png',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: CustomTextInput(
                onChanged: (String value) {},
                onClear: () {},
                prefixIcon: const Icon(Icons.search,
                    color: GlobalStyles.primaryButtonColor),
                hintText: 'Search...',
                fieldLabel: 'Search...',
                cursorColor: GlobalStyles.primaryButtonColor,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: chatUsers.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (BuildContext context, int index) {
                  final ChatUsers user = chatUsers[index];
                  return ConversationList(
                    name: user.name,
                    messageText: user.messageText,
                    number: user.number,
                    imageUrl: user.imageURL,
                    time: user.createdAt,
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
