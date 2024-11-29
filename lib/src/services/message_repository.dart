import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:babysitterapp/src/services.dart';
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
      final DocumentReference<Map<String, dynamic>> docRef =
          await _firestore.collection('messages').add(message.toJson());

      final DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
      return right(Message.fromJson(<String, dynamic>{
        ...doc.data()!,
        'id': doc.id,
      }));
    } catch (e, stack) {
      _logger.error('Failed to send message', e, stack);
      return left(AuthFailure('Failed to send message: $e'));
    }
  }

  Stream<List<Message>> getMessagesStream({
    required String currentUserId,
    required String otherUserId,
  }) {
    _logger.debug(
        'Starting messages stream between $currentUserId and $otherUserId');

    return _firestore
        .collection('messages')
        .where('senderId', whereIn: <Object?>[currentUserId, otherUserId])
        .where('receiverId', whereIn: <Object?>[currentUserId, otherUserId])
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
          try {
            return snapshot.docs
                .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
              return Message.fromJson(<String, dynamic>{
                ...doc.data(),
                'id': doc.id,
              });
            }).toList();
          } catch (e, stack) {
            _logger.error('Error processing messages snapshot', e, stack);
            rethrow;
          }
        });
  }

  Future<Either<AuthFailure, Unit>> markMessageAsRead(String messageId) async {
    try {
      await _firestore
          .collection('messages')
          .doc(messageId)
          .update(<Object, Object?>{
        'isRead': true,
      });
      return right(unit);
    } catch (e, stack) {
      _logger.error('Failed to mark message as read', e, stack);
      return left(AuthFailure('Failed to mark message as read: $e'));
    }
  }
}
