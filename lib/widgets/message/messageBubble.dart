import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomRight, // Align message bubble to the right
          child: Container(
            margin: const EdgeInsets.symmetric(
                vertical: 5), // Spacing between bubbles
            padding: const EdgeInsets.all(12), // Padding inside the bubble
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent, // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white, // Text colorrr
                fontWeight: FontWeight.w500, // Font weight
              ),
            ),
          ),
        ),
      ],
    );
  }
}
