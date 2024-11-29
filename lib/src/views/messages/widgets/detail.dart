import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class MessageDetailScreen extends HookConsumerWidget {
  const MessageDetailScreen({
    super.key,
    required this.name,
    required this.number,
    required this.image,
    required this.recipientId,
  });

  final String name;
  final String number;
  final String image;
  final String recipientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController messageController = useTextEditingController();
    final ValueNotifier<List<Message>> messages =
        useState<List<Message>>(<Message>[]);
    final ScrollController scrollController = useScrollController();
    final UserAccount? currentUser = ref.watch(authControllerService).user;

    useEffect(() {
      if (messages.value.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
      return null;
    }, <Object?>[messages.value]);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: GlobalStyles.appBarBackgroundColor,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: GlobalStyles.smallPadding),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: GlobalStyles.appBarIconColor,
                  ),
                ),
                const SizedBox(width: 2),
                CachedAvatar(
                  imageUrl: image,
                  radius: 20,
                  showOnlineStatus: true,
                  isOnline: true,
                  showVerificationStatus: true,
                  isVerified: true,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Online',
                        style: TextStyle(
                          color: Color(0xFF00C853),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final Uri url = Uri(scheme: 'tel', path: number);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      log('Cannot launch phone URL');
                    }
                  },
                  icon: const Icon(Icons.phone, color: Colors.black54),
                ),
                IconButton(
                  onPressed: () {
                    CustomRouter.navigateToWithTransition(
                      const BookingView(),
                      'rightToLeftWithFade',
                    );
                  },
                  icon: const Icon(
                    Icons.request_page_rounded,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: GlobalStyles.defaultPadding,
                vertical: GlobalStyles.defaultPadding,
              ),
              itemCount: messages.value.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages.value[index];
                return MessageBubble(
                  message: message,
                  isSender: message.senderId == currentUser?.id,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: GlobalStyles.smallPadding,
              vertical: GlobalStyles.smallPadding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: GlobalStyles.primaryButtonColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Add attachment handling
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Write message...',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        final Message newMessage = Message(
                          senderId: currentUser?.id ?? '',
                          receiverId: recipientId,
                          content: messageController.text.trim(),
                          createdAt: DateTime.now(),
                          isRead: false,
                        );
                        messages.value = <Message>[
                          ...messages.value,
                          newMessage
                        ];
                        messageController.clear();
                      }
                    },
                    backgroundColor: GlobalStyles.primaryButtonColor,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
