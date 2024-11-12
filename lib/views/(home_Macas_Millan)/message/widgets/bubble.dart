import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

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
            margin:
                const EdgeInsets.symmetric(vertical: GlobalStyles.smallPadding),
            padding: const EdgeInsets.all(GlobalStyles.defaultPadding),
            decoration: BoxDecoration(
              color: GlobalStyles.primaryButtonColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
