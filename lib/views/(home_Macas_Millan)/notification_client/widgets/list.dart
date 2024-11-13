import 'package:babysitterapp/core/helpers/goto_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:babysitterapp/core/constants.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
    required this.showButtons,
    required this.destinationScreen, // Initialize destination screen
  });

  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;
  final bool showButtons;
  final Widget destinationScreen; // New field

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
        color: const Color.fromARGB(255, 255, 255, 255),
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
            if (widget.showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // ignore: unnecessary_null_comparison
                      if (widget.destinationScreen != null) {

                        goToPage(context, widget.destinationScreen!,'rightToLeftWithFade');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalStyles.primaryButtonColor,
                    ),
                    child: const Text(
                      'View',
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
