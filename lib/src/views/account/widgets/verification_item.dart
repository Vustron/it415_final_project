import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class VerificationItem extends StatelessWidget {
  const VerificationItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isVerified,
    required this.verifiedDate,
  });

  final IconData icon;
  final String title;
  final bool isVerified;
  final DateTime? verifiedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: isVerified ? Colors.green : Colors.orange,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                isVerified
                    ? 'Verified on ${verifiedDate!.toLocal().toString().split(' ')[0]}'
                    : title == 'Email Verification'
                        ? 'Please verify your email address'
                        : 'Please upload a valid ID for verification',
                style: TextStyle(
                  fontSize: 12,
                  color: isVerified ? Colors.grey.shade600 : Colors.orange,
                  fontWeight: isVerified ? FontWeight.normal : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Icon(
          isVerified
              ? FluentIcons.checkmark_circle_24_filled
              : FluentIcons.error_circle_24_filled,
          size: 20,
          color: isVerified ? Colors.green : Colors.orange,
        ),
      ],
    );
  }
}
