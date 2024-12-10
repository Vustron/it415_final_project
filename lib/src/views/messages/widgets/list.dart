import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/views.dart';

class ConversationList extends HookWidget with GlobalStyles {
  ConversationList({
    super.key,
    required this.name,
    required this.messageText,
    required this.imageUrl,
    required this.time,
    required this.isMessageRead,
    required this.number,
    required this.recipientId,
    required this.isOnline,
    required this.isVerified,
    required this.isSender,
    this.onTap,
  });

  final bool isSender;
  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;
  final String number;
  final String recipientId;
  final bool isOnline;
  final bool isVerified;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String getMessagePreview() {
      if (messageText.isEmpty) return '';
      return isSender ? 'You: $messageText' : messageText;
    }

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap ??
            () {
              CustomRouter.navigateToWithTransition(
                MessageDetailScreen(
                  name: name,
                  number: number,
                  image: imageUrl,
                  recipientId: recipientId,
                ),
                'rightToLeftWithFade',
              );
            },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: GlobalStyles.defaultPadding,
            vertical: GlobalStyles.defaultPadding * 0.8,
          ),
          child: Row(
            children: <Widget>[
              CachedAvatar(
                imageUrl: imageUrl,
                radius: 25,
                showOnlineStatus: true,
                isOnline: isOnline,
                showVerificationStatus: true,
                isVerified: isVerified,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('MMM d, hh:mm a').format(time),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            getMessagePreview(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        if (!isMessageRead)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: GlobalStyles.primaryButtonColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
