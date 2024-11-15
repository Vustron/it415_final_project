import 'package:babysitterapp/views/(search_Layao)/search/widgets/Marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:babysitterapp/core/constants.dart';

MarkerLayer markerLayer() {
  return MarkerLayer(
    markers: <Marker>[
      marker(7.3136, 125.6703, logo, Colors.lightBlue),
      marker(7.3164, 125.6833, avatar2, GlobalStyles.kPrimaryColor),
      marker(7.3087, 125.6841, avatar1, GlobalStyles.kPrimaryColor),
    ],
  );
}
