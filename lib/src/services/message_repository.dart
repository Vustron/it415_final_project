import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';

class MessageRepository {
  MessageRepository({
    required FirebaseFirestore firestore,
    required LoggerService logger,
  })  : _firestore = firestore,
        _logger = logger;

  final FirebaseFirestore _firestore;
  final LoggerService _logger;

  Future<Either<AuthFailure, Message>> sendMessage(Message message) async {
    try {
      _logger.info(
          'Sending message from ${message.senderId} to ${message.receiverId}');

      final String messageId = NanoIdGenerator.generate();
      final Map<String, dynamic> messageData = <String, dynamic>{
        ...message.toJson(),
        'id': messageId,
      };

      await _firestore.collection('messages').doc(messageId).set(messageData);

      return right(Message.fromJson(messageData));
    } catch (e, stack) {
      _logger.error('Failed to send message', e, stack);
      return left(AuthFailure('Failed to send message: $e'));
    }
  }

  Stream<List<Message>> getMessagesStream({
    required String currentUserId,
    String? otherUserId,
  }) {
    _logger.debug('Starting messages stream for user: $currentUserId');

    Query<Map<String, dynamic>> query = _firestore.collection('messages');

    if (otherUserId?.isNotEmpty ?? false) {
      query = query.where(
        'senderId',
        whereIn: <String>[currentUserId, if (otherUserId != null) otherUserId],
      ).where(
        'receiverId',
        whereIn: <String>[currentUserId, if (otherUserId != null) otherUserId],
      );
    } else {
      query = query.where(
        Filter.or(
          Filter('senderId', isEqualTo: currentUserId),
          Filter('receiverId', isEqualTo: currentUserId),
        ),
      );
    }

    return query
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      _logger.debug('Processing ${snapshot.docs.length} messages');
      return snapshot.docs
          .map(
            (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                Message.fromJson(<String, dynamic>{
              ...doc.data(),
              'id': doc.id,
            }),
          )
          .toList();
    });
  }

  Future<void> markMessagesAsRead({
    required String currentUserId,
    required String senderId,
  }) async {
    try {
      final WriteBatch batch = _firestore.batch();

      final QuerySnapshot<Map<String, dynamic>> unreadMessages =
          await _firestore
              .collection('messages')
              .where('senderId', isEqualTo: senderId)
              .where('receiverId', isEqualTo: currentUserId)
              .where('isRead', isEqualTo: false)
              .get();

      for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
          in unreadMessages.docs) {
        batch.update(doc.reference, <String, dynamic>{'isRead': true});
      }

      await batch.commit();
      _logger.debug('Marked ${unreadMessages.docs.length} messages as read');
    } catch (e, stack) {
      _logger.error('Failed to mark messages as read', e, stack);
    }
  }
}
