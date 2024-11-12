import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class FAQTile extends HookWidget {
  const FAQTile({super.key, required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = useState(false);

    return Card(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              question,
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Icon(
              isExpanded.value
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250), // Smooth transition
            firstChild: const SizedBox.shrink(), // Hidden state
            secondChild: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ), // Expanded state
            crossFadeState: isExpanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
