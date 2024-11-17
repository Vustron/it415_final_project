import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/providers.dart';
import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/search.dart';

class DistanceSlider extends ConsumerStatefulWidget {
  const DistanceSlider({super.key});

  @override
  DistanceSliderState createState() => DistanceSliderState();
}

class DistanceSliderState extends ConsumerState<DistanceSlider> {
  @override
  Widget build(BuildContext context) {
    final double distance = ref.watch(distanceProvider);

    return filterCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sectionTitle('Distance', Icons.place),
          const SizedBox(height: 8),
          Slider(
            value: distance,
            max: 100.0,
            min: 0.1,
            divisions: 49,
            label: distance.toStringAsFixed(1),
            onChanged: (double value) {
              ref.read(distanceProvider.notifier).state = value;
            },
          ),
          Text(
            '${distance.toStringAsFixed(1)} km',
            style: TextStyle(
              color: GlobalStyles.filterColorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
