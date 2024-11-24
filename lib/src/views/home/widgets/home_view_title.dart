import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/models.dart';

Widget homeViewTitle(UserAccount? user) {
  return Row(
    children: <Widget>[
      CachedAvatar(
        imageUrl: user?.profileImg,
        radius: 25,
        showOnlineStatus: true,
        isOnline: user?.onlineStatus,
        showVerificationStatus: true,
        isVerified:
            user?.emailVerified != null && user?.validIdVerified != null,
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello,',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              user?.name ?? 'User',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    ],
  );
}
