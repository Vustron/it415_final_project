// third party
import 'package:intl/intl.dart';

// flutter
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/core/widgets/message/detail.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
  });

  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;

  @override
  ConversationListState createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute<dynamic>(builder: (BuildContext context) {
          return MessageDetailScreen(name: widget.name); // Pass the name here
        }));
      },
      child: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ColoredBox(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('hh:mm a').format(widget.time),
              style: TextStyle(
                  color: const Color(0xFF1686AA),
                  fontSize: 15,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
