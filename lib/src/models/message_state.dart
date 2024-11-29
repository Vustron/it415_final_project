import 'package:babysitterapp/src/models.dart';

class MessageState {
  MessageState({
    this.messages = const <Message>[],
    this.isLoading = false,
    this.error,
  });

  final List<Message> messages;
  final bool isLoading;
  final String? error;

  MessageState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
