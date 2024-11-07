import 'package:flutter/material.dart';

class SupportTile extends StatelessWidget {
  const SupportTile({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        onTap: () {
          // Action logic here
        },
      ),
    );
  }
}
