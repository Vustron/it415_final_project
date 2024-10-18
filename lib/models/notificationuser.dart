class NotificationUsers {
  NotificationUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.createdAt,
    required this.updatedAt,
    this.showButtons = false, // Add this
  });

  factory NotificationUsers.fromMap(Map<String, dynamic> data) {
    return NotificationUsers(
      name: data['name'] as String,
      messageText: data['messageText'] as String,
      imageURL: data['imageURL'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
      showButtons: data['showButtons'] as bool? ?? false, // Optional in data
    );
  }

  final String name;
  final String messageText;
  final String imageURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool showButtons; // New field to control button visibility
}
