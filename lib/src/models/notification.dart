
import 'package:flutter/material.dart';

class NotificationUsers {
  NotificationUsers({
    required this.name,
    required this.messageText,
    required this.imageURL,
    required this.createdAt,
    required this.updatedAt,
    this.showButtons = false,
    this.destinationScreen, // Initialize destination screen
  });

  factory NotificationUsers.fromMap(Map<String, dynamic> data) {
    return NotificationUsers(
      name: data['name'] as String,
      messageText: data['messageText'] as String,
      imageURL: data['imageURL'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
      showButtons: data['showButtons'] as bool? ?? false, 
       // ignore: avoid_redundant_argument_values
       destinationScreen: null, // Default to `null` if not provided


    );
  }

  final String name;
  final String messageText;
  final String imageURL;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool showButtons;
  final Widget? destinationScreen; // New field
}
