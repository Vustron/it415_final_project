// utils
import 'package:babysitterapp/core/components/input.dart';
import 'package:flutter/material.dart';

// models
import 'package:babysitterapp/models/chatuser.dart';

// widgets
import 'package:babysitterapp/views/message/widgets/list.dart';

// core
import 'package:babysitterapp/core/constants/styles.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageView> {
  final List<ChatUsers> chatUsers = <ChatUsers>[
    ChatUsers(name: 'Jane Russel', messageText: 'Awesome Setup', number: '0920333181', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now(), updatedAt: DateTime.now(),),
    ChatUsers(name: "Glady's Murphy", messageText: "That's Great", number: '097569341398', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 1)),updatedAt: DateTime.now().subtract(const Duration(days: 1)),),
    ChatUsers(name: 'Jorge Henry', messageText: 'Hey where are you?', number: '0930698568', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 2)),updatedAt: DateTime.now().subtract(const Duration(days: 2)),),
    ChatUsers(name: 'Philip Fox', messageText: 'Busy! Call me in 20 mins', number: '09403994556', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 3)),updatedAt: DateTime.now().subtract(const Duration(days: 3)),),
    ChatUsers(name: 'Debra Hawkins', messageText: "Thank you, It's awesome", number: '095058564852', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 4)),updatedAt: DateTime.now().subtract(const Duration(days: 4)),),
    ChatUsers(name: 'Jacob Pena', messageText: 'Will update you in the evening', number: '09905796152', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 5)),updatedAt: DateTime.now().subtract(const Duration(days: 5)),),
    ChatUsers(name: 'Andrew Jones', messageText: 'Can you please share the file?', number: '09718693268', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 6)),updatedAt: DateTime.now().subtract(const Duration(days: 6)),),
    ChatUsers(name: 'John Wick', messageText: 'How are you?', number: '0940752757', imageURL: 'assets/images/placeholder_logo.png', createdAt: DateTime.now().subtract(const Duration(days: 7)),updatedAt: DateTime.now().subtract(const Duration(days: 7)),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
        title: const Text('Message'),
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
                prefixIcon: const Icon(Icons.search, color: GlobalStyles.primaryButtonColor),
                hintText: 'Search...',
                cursorColor: GlobalStyles.primaryButtonColor,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: chatUsers.length,
                padding: const EdgeInsets.only(top: 16),
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
