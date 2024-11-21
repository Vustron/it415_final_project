import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class CachedAvatar extends StatelessWidget {
  const CachedAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40,
  });

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: Icon(
          FluentIcons.person_32_regular,
          size: radius * 1.2,
          color: GlobalStyles.primaryButtonColor,
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
          placeholder: (BuildContext context, String url) => const Center(
            child: CircularProgressIndicator(
              color: GlobalStyles.primaryButtonColor,
            ),
          ),
          errorWidget: (BuildContext context, String url, Object error) => Icon(
            FluentIcons.person_32_regular,
            size: radius * 1.2,
            color: GlobalStyles.primaryButtonColor,
          ),
        ),
      ),
    );
  }
}
