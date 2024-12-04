import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/models.dart';

class MarkerData {
  MarkerData({
    required this.user,
    required this.role,
  });

  final UserAccount user;
  final String role;

  LatLng get position => LatLng(
        double.parse(user.addressLatitude ?? '0'),
        double.parse(user.addressLongitude ?? '0'),
      );
}
