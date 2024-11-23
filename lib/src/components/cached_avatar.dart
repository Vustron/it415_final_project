import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class CachedAvatar extends StatelessWidget {
  const CachedAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40,
    this.showOnlineStatus = false,
    this.isOnline,
    this.showVerificationStatus = false,
    this.isVerified,
  });

  final String? imageUrl;
  final double radius;
  final bool showOnlineStatus;
  final bool? isOnline;
  final bool showVerificationStatus;
  final bool? isVerified;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: showOnlineStatus && isOnline != null
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isOnline! ? Colors.green : Colors.grey,
                    width: 3,
                  ),
                )
              : null,
          child: imageUrl == null || imageUrl!.isEmpty
              ? CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white,
                  child: Icon(
                    FluentIcons.person_32_regular,
                    size: radius * 1.2,
                    color: GlobalStyles.primaryButtonColor,
                  ),
                )
              : CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      width: radius * 2,
                      height: radius * 2,
                      placeholder: (BuildContext context, String url) =>
                          const Center(
                        child: CircularProgressIndicator(
                          color: GlobalStyles.primaryButtonColor,
                        ),
                      ),
                      errorWidget:
                          (BuildContext context, String url, Object error) =>
                              Icon(
                        FluentIcons.person_32_regular,
                        size: radius * 1.2,
                        color: GlobalStyles.primaryButtonColor,
                      ),
                    ),
                  ),
                ),
        ),
        if (showVerificationStatus && isVerified != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.7,
              height: radius * 0.7,
              decoration: BoxDecoration(
                color: isVerified! ? Colors.blue : Colors.orange,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  isVerified! ? Icons.verified_rounded : Icons.warning_rounded,
                  size: radius * 0.4,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
