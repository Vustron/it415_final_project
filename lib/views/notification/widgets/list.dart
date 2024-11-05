// third party
import 'package:intl/intl.dart';

// flutter
import 'package:flutter/material.dart';

// dart
import 'dart:developer';
// styles
import '../../../core/constants/styles.dart'; // Import your styles file



class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
    required this.showButtons,
  });

  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;
  final bool showButtons;

  @override
  NotificationListState createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  void onConfirm() {
    log('${widget.name} confirmed');
  }

  void onDecline() {
    log('${widget.name} declined');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white, // Default container color
        padding: const EdgeInsets.all(GlobalStyles.smallPadding), // Use smallPadding
        child: Column(
          children: <Widget>[
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
                          color: Colors.black,
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
                    color: GlobalStyles.appBarIconColor, // Use appBarIconColor
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
                children: <Widget>[
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalStyles.primaryButtonColor, // Use primaryButtonColor
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
                      backgroundColor: Colors.grey, // Use a defined color from styles if available
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
