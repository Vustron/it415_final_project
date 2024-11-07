import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'package:babysitterapp/views/(home_Macas_Millan)/notification/booking/detail.dart';

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
        color: Colors.white,
        padding: const EdgeInsets.all(GlobalStyles.smallPadding),
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
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: widget.isMessageRead
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('hh:mm a').format(widget.time),
                  style: TextStyle(
                    color: GlobalStyles.appBarIconColor,
                    fontSize: 12,
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
                      backgroundColor: GlobalStyles.primaryButtonColor,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      goToPage(context, const BookingDetailNotification(),
                          'rightToLeftWithFade');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalStyles.primaryButtonColor,
                    ),
                    child: const Text(
                      'View',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: onDecline,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
