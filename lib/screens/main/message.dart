// utils
import 'package:flutter/material.dart';

// models
import 'package:babysitterapp/models/chatuser.dart';

// widgets
import 'package:babysitterapp/widgets/message/list.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  List<ChatUsers> chatUsers = <ChatUsers>[
    ChatUsers(
        name: 'Jane Russel', // Corrected from `text` to `name`
        messageText:
            'Awesome Setup', // Corrected from `secondaryText` to `messageText`
        imageURL: 'assets/images/placeholder_logo.png',
        time: 'Now'),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL: 'assets/images/placeholder_logo.png',
        time: 'Yesterday'),
    ChatUsers(
        name: 'Jorge Henry',
        messageText: 'Hey where are you?',
        imageURL: 'assets/images/placeholder_logo.png',
        time: '31 Mar'),
    ChatUsers(
        name: 'Philip Fox',
        messageText: 'Busy! Call me in 20 mins',
        imageURL: 'assets/images/placeholder_logo.png',
        time: '28 Mar'),
    ChatUsers(
        name: 'Debra Hawkins',
        messageText: "Thank you, It's awesome",
        imageURL: 'assets/images/placeholder_logo.png',
        time: '23 Mar'),
    ChatUsers(
        name: 'Jacob Pena',
        messageText: 'Will update you in the evening',
        imageURL: 'assets/images/placeholder_logo.png',
        time: '17 Mar'),
    ChatUsers(
        name: 'Andrey Jones',
        messageText: 'Can you please share the file?',
        imageURL: 'assets/images/placeholder_logo.png',
        time: '24 Feb'),
    ChatUsers(
        name: 'John Wick',
        messageText: 'How are you?',
        imageURL: 'assets/images/placeholder_logo.png',
        time: '18 Feb'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
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
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 20,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Add New',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (BuildContext context, int index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
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
