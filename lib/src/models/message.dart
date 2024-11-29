class Message {
  const Message({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] as String?,
        senderId: json['senderId'] as String,
        receiverId: json['receiverId'] as String,
        content: json['content'] as String,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
        isRead: json['isRead'] as bool? ?? false,
      );

  final String? id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isRead;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'content': content,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'isRead': isRead,
      };

  Message copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
