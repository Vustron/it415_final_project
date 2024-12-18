import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dartz/dartz.dart';
import 'dart:async';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class MessageController extends StateNotifier<MessageState> {
  MessageController(this.messageRepo, this.logger) : super(MessageState());

  final MessageRepository messageRepo;
  final LoggerService logger;
  StreamSubscription<List<Message>>? _messagesSubscription;

  String? _currentUserId;
  String? _otherUserId;

  void initMessagesStream({
    required String currentUserId,
    required String otherUserId,
  }) {
    _currentUserId = currentUserId;
    _otherUserId = otherUserId;

    logger.debug('Initializing messages stream');
    _messagesSubscription?.cancel();

    state = state.copyWith(isLoading: true);

    _messagesSubscription = messageRepo
        .getMessagesStream(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
    )
        .listen(
      (List<Message> messages) {
        state = state.copyWith(
          messages: messages,
          isLoading: false,
        );
      },
      onError: (dynamic error, StackTrace stack) {
        logger.error('Messages stream error', error, stack);
        state = state.copyWith(
          isLoading: false,
          error: error.toString(),
        );
      },
    );
  }

  void refreshMessages() {
    if (_currentUserId == null) {
      logger.warning('Cannot refresh - stream not initialized');
      return;
    }

    logger.debug('Refreshing messages stream');

    initMessagesStream(
      currentUserId: _currentUserId!,
      otherUserId: _otherUserId ?? '',
    );
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      final Message message = Message(
        senderId: senderId,
        receiverId: receiverId,
        content: content,
        createdAt: DateTime.now(),
        isRead: false,
      );

      final Either<AuthFailure, Message> result =
          await messageRepo.sendMessage(message);
      result.fold(
        (AuthFailure failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
          );
        },
        (_) {
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e, stack) {
      logger.error('Send message error', e, stack);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markMessagesAsRead({
    required String currentUserId,
    required String senderId,
  }) async {
    try {
      await messageRepo.markMessagesAsRead(
        currentUserId: currentUserId,
        senderId: senderId,
      );
    } catch (e, stack) {
      logger.error('Failed to mark messages as read', e, stack);
    }
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }

  Stream<List<Message>> getMessagesStream({
    required String currentUserId,
    required String otherUserId,
  }) {
    logger.debug('Getting messages stream');
    return messageRepo
        .getMessagesStream(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
    )
        .handleError((dynamic error, StackTrace stack) {
      logger.error('Error in messages stream', error, stack);
      throw Exception('Stream error in getMessagesStream: $error');
    });
  }
}
