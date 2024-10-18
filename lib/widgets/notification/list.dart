// utils
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
    required this.showButtons, // New parameter to control button visibility
  });

  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;
  final bool showButtons; // To determine if buttons should be shown

  @override
  NotificationListState createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  void onConfirm() {
    // Handle the confirm action here
    print('${widget.name} confirmed');
  }

  void onDecline() {
    // Handle the decline action here
    print('${widget.name} declined');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(widget.imageUrl),
                  maxRadius: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.name, style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 6),
                      Text(
                        widget.messageText,
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: widget.isMessageRead
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(widget.time),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: widget.isMessageRead
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Only show buttons if 'showButtons' is true
            if (widget.showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(22, 134, 170,
                          1), // Corrected Color values (R, G, B, opacity)
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: onDecline,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Decline button color
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
