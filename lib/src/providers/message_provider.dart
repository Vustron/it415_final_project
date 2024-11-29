import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

final Provider<MessageRepository> messageRepositoryService =
    Provider<MessageRepository>((ProviderRef<MessageRepository> ref) {
  return MessageRepository(
    firestore: ref.watch(firebaseFirestoreService),
    logger: ref.watch(loggerService),
  );
});

final StateNotifierProvider<MessageController, MessageState>
    messageControllerService =
    StateNotifierProvider<MessageController, MessageState>(
        (StateNotifierProviderRef<MessageController, MessageState> ref) {
  return MessageController(
    ref.watch(messageRepositoryService),
    ref.watch(loggerService),
  );
});
