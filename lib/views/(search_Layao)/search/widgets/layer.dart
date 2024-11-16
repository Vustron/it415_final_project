import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/search.dart';

MarkerLayer markerLayer() {
  return MarkerLayer(
    markers: <Marker>[
      markerWidget(7.3136, 125.6703, logo, Colors.lightBlue),
      markerWidget(7.3164, 125.6833, avatar2, GlobalStyles.kPrimaryColor),
      markerWidget(7.3087, 125.6841, avatar1, GlobalStyles.kPrimaryColor),
    ],
  );
}
