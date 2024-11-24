import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class VerificationCard extends StatelessWidget with GlobalStyles {
  VerificationCard({
    super.key,
    required this.user,
  });

  final UserAccount user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Verification Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            VerificationItem(
              icon: FluentIcons.mail_24_regular,
              title: 'Email Verification',
              isVerified: user.emailVerified != null &&
                  user.email != null &&
                  user.email!.isNotEmpty &&
                  user.email != '',
              verifiedDate: user.emailVerified,
            ),
            const SizedBox(height: 12),
            VerificationItem(
              icon: FluentIcons.document_24_regular,
              title: 'ID Verification',
              isVerified: user.validIdVerified != null &&
                  user.validId != null &&
                  user.validId!.isNotEmpty &&
                  user.validId != '',
              verifiedDate: user.validIdVerified,
            ),
          ],
        ),
      ),
    );
  }
}
