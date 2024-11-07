// flutter
import 'package:flutter/material.dart';
// styles
import 'package:babysitterapp/core/constants/styles.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: GlobalStyles.smallPadding), // Use smallPadding
            padding: const EdgeInsets.all(GlobalStyles.defaultPadding), // Use defaultPadding
            decoration: BoxDecoration(
              color: GlobalStyles.primaryButtonColor, // Use primaryButtonColor
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white, // Keep the text color white
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
