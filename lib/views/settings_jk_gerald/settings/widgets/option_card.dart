import 'package:flutter/material.dart';

class SettingsOptionCard extends StatelessWidget {
  const SettingsOptionCard({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.showDropdownIcon = false,
    this.isExpanded = false,
    // ignore: avoid_unused_constructor_parameters
    required TextStyle style,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool showDropdownIcon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Icon(icon, color: Colors.black),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: showDropdownIcon
            ? Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 20)
            : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
