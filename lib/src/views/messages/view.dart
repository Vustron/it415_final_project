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
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class MessageView extends HookConsumerWidget with GlobalStyles {
  MessageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState authState = ref.watch(authControllerService);
    final MessageController messageController =
        ref.watch(messageControllerService.notifier);
    final ValueNotifier<String> searchQuery = useState('');

    final Stream<List<Message>> messagesStream = useMemoized(
      () => messageController.getMessagesStream(
        currentUserId: authState.user?.id ?? '',
        otherUserId: '',
      ),
      <Object?>[authState.user?.id],
    );

    final AsyncSnapshot<List<Message>> messagesSnapshot =
        useStream(messagesStream);
    final Map<String, Message> latestMessages = useMemoized(() {
      if (!messagesSnapshot.hasData) return <String, Message>{};

      final List<Message> messages = messagesSnapshot.data!;
      final Map<String, Message> latest = <String, Message>{};

      for (final Message message in messages) {
        final String otherId = message.senderId == authState.user?.id
            ? message.receiverId
            : message.senderId;

        if (!latest.containsKey(otherId) ||
            (message.createdAt?.isAfter(latest[otherId]!.createdAt!) ??
                false)) {
          latest[otherId] = message;
        }
      }

      return latest;
    }, <Object?>[messagesSnapshot.data]);

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
      body: SafeArea(
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

                  if (latestMessages.isEmpty) {
                    return const Center(
                      child: Text('No messages yet'),
                    );
                  }

                  return ListView.builder(
                    itemCount: latestMessages.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (BuildContext context, int index) {
                      final Message message =
                          latestMessages.values.elementAt(index);
                      final String otherUserId =
                          message.senderId == authState.user?.id
                              ? message.receiverId
                              : message.senderId;

                      final Stream<Either<AuthFailure, UserAccount>>
                          userDataStream = useMemoized(
                        () => ref
                            .read(authControllerService.notifier)
                            .getUserDataStream(otherUserId),
                        <Object?>[otherUserId],
                      );

                      final AsyncSnapshot<Either<AuthFailure, UserAccount>>
                          userSnapshot = useStream(userDataStream);

                      if (!userSnapshot.hasData) {
                        return const SizedBox.shrink();
                      }

                      return userSnapshot.data!.fold(
                        (AuthFailure failure) => const SizedBox.shrink(),
                        (UserAccount otherUser) {
                          if (searchQuery.value.isNotEmpty &&
                              !otherUser.name!
                                  .toLowerCase()
                                  .contains(searchQuery.value.toLowerCase())) {
                            return const SizedBox.shrink();
                          }

                          return ConversationList(
                            name: otherUser.name ?? 'No Name',
                            messageText: message.content,
                            number: otherUser.phoneNumber ?? '',
                            imageUrl: otherUser.profileImg ?? '',
                            time: message.createdAt ?? DateTime.now(),
                            isMessageRead: message.isRead,
                            recipientId: otherUserId, // Add this
                            // onTap: () {
                            //   CustomRouter.navigateToWithTransition(
                            //     ChatView(recipientId: otherUserId),
                            //     'rightToLeftWithFade',
                            //   );
                            // },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
