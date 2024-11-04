class ChatUsers {
  ChatUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.createdAt,
    required this.updatedAt,
    required this.number,
  });

  factory ChatUsers.fromMap(Map<String, dynamic> data) {
    return ChatUsers(
      name: data['name'] as String,
      messageText: data['messageText'] as String,
      imageURL: data['imageURL'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
      number: data['number'] as String, // Ensure this is assigned as a String
    );
  }

  final String name;
  final String messageText;
  final String imageURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String number; // Define number as String
}
