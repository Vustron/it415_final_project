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
    this.onTap,
  });

  final String name;
  final String messageText;
  final String imageUrl;
  final DateTime time;
  final bool isMessageRead;
  final String number;
  final String recipientId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
                isOnline: true,
                showVerificationStatus: true,
                isVerified: true,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isMessageRead
                                  ? FontWeight.w600
                                  : FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(time),
                          style: TextStyle(
                            color: isMessageRead
                                ? Colors.grey[600]
                                : GlobalStyles.primaryButtonColor,
                            fontSize: 12,
                            fontWeight: isMessageRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            messageText,
                            style: TextStyle(
                              fontSize: 14,
                              color: isMessageRead
                                  ? Colors.grey[600]
                                  : Colors.black87,
                              fontWeight: isMessageRead
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
