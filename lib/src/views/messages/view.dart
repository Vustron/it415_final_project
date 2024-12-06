import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

final StateNotifierProvider<MessageListCacheNotifier,
        Map<String, List<Message>>> messagesCacheProvider =
    StateNotifierProvider<MessageListCacheNotifier, Map<String, List<Message>>>(
        (StateNotifierProviderRef<MessageListCacheNotifier,
                Map<String, List<Message>>>
            ref) {
  return MessageListCacheNotifier();
});

class MessageListCacheNotifier
    extends StateNotifier<Map<String, List<Message>>> {
  MessageListCacheNotifier() : super(<String, List<Message>>{});

  void updateMessages(String chatId, List<Message> messages) {
    final List<Message> existing = state[chatId] ?? <Message>[];
    final List<Message> newMessages = messages
        .where((Message msg) =>
            !existing.any((Message cached) => cached.id == msg.id))
        .toList();

    if (newMessages.isNotEmpty) {
      state = <String, List<Message>>{
        ...state,
        chatId: <Message>[...existing, ...newMessages]..sort(
            (Message a, Message b) => (b.createdAt ?? DateTime.now())
                .compareTo(a.createdAt ?? DateTime.now())),
      };
    }
  }
}

class MessageView extends HookConsumerWidget with GlobalStyles {
  MessageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerService);
    final MessageController messageController =
        ref.watch(messageControllerService.notifier);
    final ValueNotifier<String> searchQuery = useState('');
    ref.watch(messagesCacheProvider);

    final Stream<List<Message>> messagesStream = useMemoized(
      () => messageController.getMessagesStream(
        currentUserId: authState.user?.id ?? '',
        otherUserId: '',
      ),
      <Object?>[authState.user?.id],
    );

    final AsyncSnapshot<List<Message>> messagesSnapshot =
        useStream(messagesStream);

    final UserAccount? currentUser = authState.user;
    final Map<String, Message> groupedMessages = useMemoized(() {
      if (!messagesSnapshot.hasData) return <String, Message>{};

      final List<Message> messages = messagesSnapshot.data!;
      final Map<String, Message> grouped = <String, Message>{};

      for (final Message message in messages) {
        final String otherId = message.senderId == currentUser?.id
            ? message.receiverId
            : message.senderId;

        if (!grouped.containsKey(otherId) ||
            (message.senderId != currentUser?.id &&
                !grouped[otherId]!.isRead) ||
            message.createdAt!.isAfter(grouped[otherId]!.createdAt!)) {
          grouped[otherId] = message;
        }
      }

      return grouped;
    }, <Object?>[messagesSnapshot.data]);

    final List<Message> filteredMessages = useMemoized(() {
      if (!messagesSnapshot.hasData) return <Message>[];

      final List<Message> messages = groupedMessages.values.toList()
        ..sort((Message a, Message b) => (b.createdAt ?? DateTime.now())
            .compareTo(a.createdAt ?? DateTime.now()));

      if (searchQuery.value.isEmpty) return messages;

      return messages;
    }, <Object?>[groupedMessages, searchQuery.value]);

    Future<void> handleRefresh() async {
      ref.read(messagesCacheProvider.notifier).updateMessages('', <Message>[]);
      messageController.refreshMessages();
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: VerificationGuard(
        user: currentUser,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: CustomTextInput(
                  onChanged: (String value) => searchQuery.value = value,
                  onClear: () => searchQuery.value = '',
                  prefixIcon: Icon(
                    FluentIcons.search_24_regular,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  hintText: 'Search messages...',
                  fieldLabel: 'Search messages...',
                  cursorColor: GlobalStyles.primaryButtonColor,
                  fillColor: Colors.white,
                  textColor: Colors.black87,
                  hintColor: Colors.grey[600],
                  borderColor: Colors.grey[300],
                  focusedBorderColor: GlobalStyles.primaryButtonColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  borderRadius: 12,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: handleRefresh,
                  color: GlobalStyles.primaryButtonColor,
                  child: Builder(
                    builder: (BuildContext context) {
                      if (messagesSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: GlobalStyles.primaryButtonColor,
                          ),
                        );
                      }

                      if (messagesSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${messagesSnapshot.error}'),
                        );
                      }

                      if (filteredMessages.isEmpty) {
                        return const Center(
                          child: Text('No messages yet'),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredMessages.length,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (BuildContext context, int index) {
                          final Message message = filteredMessages[index];
                          final String otherUserId =
                              message.senderId == authState.user?.id
                                  ? message.receiverId
                                  : message.senderId;

                          return StreamBuilder<
                              Either<AuthFailure, UserAccount>>(
                            stream: ref
                                .read(authControllerService.notifier)
                                .getUserDataStream(otherUserId),
                            builder: (BuildContext context,
                                AsyncSnapshot<Either<AuthFailure, UserAccount>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox.shrink();
                              }

                              return snapshot.data!.fold(
                                (AuthFailure failure) =>
                                    const SizedBox.shrink(),
                                (UserAccount otherUser) {
                                  if (searchQuery.value.isNotEmpty &&
                                      !otherUser.name!.toLowerCase().contains(
                                          searchQuery.value.toLowerCase())) {
                                    return const SizedBox.shrink();
                                  }

                                  return ConversationList(
                                    name: otherUser.name ?? 'No Name',
                                    messageText: message.content,
                                    number: otherUser.phoneNumber ?? '',
                                    imageUrl: otherUser.profileImg ?? '',
                                    time: message.createdAt ?? DateTime.now(),
                                    isMessageRead: message.isRead,
                                    recipientId: otherUserId,
                                    isSender:
                                        message.senderId == authState.user?.id,
                                    isOnline: otherUser.onlineStatus ?? false,
                                    isVerified:
                                        otherUser.emailVerified != null &&
                                            otherUser.validIdVerified != null,
                                    onTap: () {
                                      CustomRouter.navigateToWithTransition(
                                        MessageDetailScreen(
                                          name: otherUser.name ?? 'No Name',
                                          number: otherUser.phoneNumber ?? '',
                                          image: otherUser.profileImg ?? '',
                                          recipientId: otherUserId,
                                        ),
                                        'rightToLeftWithFade',
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
