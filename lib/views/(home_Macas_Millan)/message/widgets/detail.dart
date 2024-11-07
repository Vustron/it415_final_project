import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'bubble.dart';

import 'package:babysitterapp/views/(booking_runa)/booking/view.dart';

class MessageDetailScreen extends StatefulWidget {
  const MessageDetailScreen(
      {super.key, required this.name, required this.number});
  final String name;
  final String number;

  @override
  MessageDetailScreenState createState() => MessageDetailScreenState();
}

class MessageDetailScreenState extends State<MessageDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor:
            GlobalStyles.appBarBackgroundColor, // Use appBarBackgroundColor
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
                right: GlobalStyles.smallPadding), // Use smallPadding
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: GlobalStyles.appBarIconColor, // Use appBarIconColor
                  ),
                ),
                const SizedBox(width: 2),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/hippo.png'),
                  maxRadius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Online',
                        style: TextStyle(
                          color: Color.fromARGB(255, 1, 234, 24),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final Uri url = Uri(scheme: 'tel', path: widget.number);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      log('cannot Launch this url');
                    }
                  },
                  icon: const Icon(Icons.phone, color: Colors.black54),
                ),
                IconButton(
                  onPressed: () {
                    goToPage(
                        context, const BookingView(), 'rightToLeftWithFade');
                  },
                  icon: const Icon(Icons.request_page_rounded,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlobalStyles.defaultPadding, // Use defaultPadding
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: messages
                      .map((String message) => MessageBubble(
                            message: message,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(
                  left: GlobalStyles.smallPadding, // Use smallPadding
                  bottom: GlobalStyles.smallPadding,
                  top: GlobalStyles.smallPadding,
                ),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: GlobalStyles
                              .primaryButtonColor, // Use primaryButtonColor
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Write message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    FloatingActionButton.small(
                      onPressed: () {
                        setState(() {
                          if (_messageController.text.isNotEmpty) {
                            messages.add(_messageController.text);
                            _messageController.clear();
                          }
                        });
                      },
                      backgroundColor: GlobalStyles
                          .primaryButtonColor, // Use primaryButtonColor
                      elevation: 0,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
