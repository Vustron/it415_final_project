import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'dart:developer';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

final StateNotifierProvider<MessageCacheNotifier, Map<String, List<Message>>>
    messageCacheProvider =
    StateNotifierProvider<MessageCacheNotifier, Map<String, List<Message>>>(
  (StateNotifierProviderRef<MessageCacheNotifier, Map<String, List<Message>>>
          ref) =>
      MessageCacheNotifier(),
);

class MessageCacheNotifier extends StateNotifier<Map<String, List<Message>>> {
  MessageCacheNotifier() : super(<String, List<Message>>{});

  void updateMessages(String chatId, List<Message> messages) {
    final List<Message> existing = state[chatId] ?? <Message>[];
    final Message? lastMessage = existing.isEmpty ? null : existing.last;
    final Message? latestMessage = messages.isEmpty ? null : messages.last;

    if (lastMessage?.id != latestMessage?.id ||
        lastMessage?.createdAt != latestMessage?.createdAt) {
      final List<Message> newMessages = messages
          .where((Message msg) =>
              !existing.any((Message cached) => cached.id == msg.id))
          .toList();

      if (newMessages.isNotEmpty) {
        state = <String, List<Message>>{
          ...state,
          chatId: <Message>[...existing, ...newMessages]..sort(
              (Message a, Message b) => (a.createdAt ?? DateTime.now())
                  .compareTo(b.createdAt ?? DateTime.now())),
        };
      }
    }
  }

  void addMessage(String chatId, Message message) {
    final List<Message> existing = state[chatId] ?? <Message>[];
    if (!existing.any((Message m) => m.id == message.id)) {
      state = <String, List<Message>>{
        ...state,
        chatId: <Message>[...existing, message]..sort((Message a, Message b) =>
            (a.createdAt ?? DateTime.now())
                .compareTo(b.createdAt ?? DateTime.now())),
      };
    }
  }
}

final StreamProviderFamily<UserAccount?, String> recipientDataProvider =
    StreamProvider.family<UserAccount?, String>(
        (StreamProviderRef<UserAccount?> ref, String recipientId) {
  return ref
      .read(authControllerService.notifier)
      .getUserDataStream(recipientId)
      .map(
        (Either<AuthFailure, UserAccount> either) => either.fold(
          (AuthFailure failure) => null,
          (UserAccount user) => user,
        ),
      );
});

final StreamProviderFamily<List<Message>, String> messagesStreamProvider =
    StreamProvider.family<List<Message>, String>(
        (StreamProviderRef<List<Message>> ref, String recipientId) {
  final UserAccount? currentUser = ref.watch(authControllerService).user;
  final Map<String, List<Message>> cache = ref.watch(messageCacheProvider);
  final List<Message> cachedMessages = cache[recipientId] ?? <Message>[];

  return ref
      .read(messageControllerService.notifier)
      .getMessagesStream(
        currentUserId: currentUser?.id ?? '',
        otherUserId: recipientId,
      )
      .distinct()
      .map((List<Message> messages) {
    if (messages.length != cachedMessages.length ||
        messages.any((Message msg) => !cachedMessages.contains(msg))) {
      ref
          .read(messageCacheProvider.notifier)
          .updateMessages(recipientId, messages);
    }
    return messages;
  });
});

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
    final ScrollController scrollController = useScrollController();
    final UserAccount? currentUser = ref.watch(authControllerService).user;
    final Toast toast = ref.watch(toastService);

    final AsyncValue<UserAccount?> recipientData =
        ref.watch(recipientDataProvider(recipientId));
    final AsyncValue<List<Message>> messages =
        ref.watch(messagesStreamProvider(recipientId));
    final Map<String, List<Message>> messageCache =
        ref.watch(messageCacheProvider);

    final bool isOnline = recipientData.value?.onlineStatus ?? false;

    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    Future<void> handleSendMessage() async {
      if (messageController.text.trim().isNotEmpty) {
        try {
          final Message newMessage = Message(
            senderId: currentUser?.id ?? '',
            receiverId: recipientId,
            content: messageController.text.trim(),
            createdAt: DateTime.now(),
          );

          await ref.read(messageControllerService.notifier).sendMessage(
                senderId: newMessage.senderId,
                receiverId: newMessage.receiverId,
                content: newMessage.content,
              );

          messageController.clear();
          scrollToBottom();
        } catch (e) {
          if (context.mounted) {
            toast.show(
              context: context,
              title: 'Error',
              message: 'Failed to send message: $e',
              type: 'error',
            );
          }
        }
      }
    }

    Future<void> handleRefresh() async {
      ref
          .read(messageCacheProvider.notifier)
          .updateMessages(recipientId, <Message>[]);
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

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
                    FluentIcons.arrow_left_24_regular,
                    color: GlobalStyles.appBarIconColor,
                  ),
                ),
                const SizedBox(width: 2),
                CachedAvatar(
                  imageUrl: image,
                  radius: 20,
                  showOnlineStatus: true,
                  isOnline: isOnline,
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
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color:
                              isOnline ? const Color(0xFF00C853) : Colors.grey,
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
                  icon: const Icon(
                    FluentIcons.call_add_24_regular,
                    color: Colors.black54,
                  ),
                ),
                if (currentUser?.role == 'Client')
                  IconButton(
                    onPressed: () {
                      CustomRouter.navigateToWithTransition(
                        BookingView(babysitterId: recipientId),
                        'rightToLeftWithFade',
                      );
                    },
                    icon: const Icon(
                      FluentIcons.guest_add_24_regular,
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
            child: RefreshIndicator(
              onRefresh: handleRefresh,
              color: GlobalStyles.primaryButtonColor,
              child: messages.when(
                data: (List<Message> messagesList) {
                  final List<Message> displayMessages =
                      messageCache[recipientId] ?? messagesList;

                  if (displayMessages.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('No messages yet'),
                          ),
                        ),
                      ],
                    );
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });

                  return ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: GlobalStyles.defaultPadding,
                      vertical: GlobalStyles.defaultPadding,
                    ),
                    itemCount: displayMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = displayMessages[index];
                      return MessageBubble(
                        message: message,
                        isSender: message.senderId == currentUser?.id,
                      );
                    },
                  );
                },
                loading: () => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const <Widget>[
                    Center(
                      child: CircularProgressIndicator(
                        color: GlobalStyles.primaryButtonColor,
                      ),
                    ),
                  ],
                ),
                error: (Object error, StackTrace stack) => ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Center(
                      child: Text('Error: $error'),
                    ),
                  ],
                ),
              ),
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
                  const SizedBox(width: 20),
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
                      onSubmitted: (_) => handleSendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    mini: true,
                    onPressed: handleSendMessage,
                    backgroundColor: GlobalStyles.primaryButtonColor,
                    elevation: 0,
                    child: const Icon(
                      FluentIcons.send_24_filled,
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
