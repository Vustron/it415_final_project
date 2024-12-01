import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/components.dart';

class LocationPreview extends StatelessWidget {
  const LocationPreview({
    super.key,
    required this.latitude,
    required this.longitude,
    this.hideTitle = false,
  });

  final double latitude;
  final double longitude;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MapScreen(
          initialLocation: LatLng(latitude, longitude),
          isReadOnly: true,
          hideTitle: hideTitle,
        ),
      ),
    );
  }
}
