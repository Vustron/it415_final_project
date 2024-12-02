import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class VerificationGuard extends ConsumerWidget {
  const VerificationGuard({
    super.key,
    required this.user,
    required this.child,
  });

  final UserAccount? user;
  final Widget child;

  bool get isVerified =>
      user?.emailVerified != null &&
      (user?.role != 'Babysitter' || user?.validIdVerified != null);

  String get verificationMessage {
    if (user == null) return '';

    final List<String> unverified = <String>[];

    if (user?.emailVerified == null) {
      unverified.add('email');
    }

    if (user?.role == 'Babysitter' && user?.validIdVerified == null) {
      unverified.add('valid ID');
    }

    return unverified.isEmpty
        ? ''
        : 'Please verify your ${unverified.join(' and ')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (user == null) {
      return const SizedBox.shrink();
    }

    if (!isVerified) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          width: 400,
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.orange.shade200,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        FluentIcons.warning_24_filled,
                        color: Colors.orange.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Account Not Verified',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            verificationMessage,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => CustomRouter.navigateToWithTransition(
                      const VerificationView(),
                      'rightToLeftWithFade',
                    ),
                    icon: const Icon(
                      FluentIcons.shield_checkmark_24_filled,
                      size: 20,
                    ),
                    label: const Text(
                      'Verify Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return child;
  }
}
