// utils
import 'package:babysitterapp/utils/styles.dart';
import 'package:flutter/material.dart';

// widgets
import 'section_title.dart';
import 'card.dart';

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({super.key});

  @override
  DistanceSliderState createState() => DistanceSliderState();
}

class DistanceSliderState extends State<DistanceSlider> {
  double distance = 15;

  @override
  Widget build(BuildContext context) {
    return filterCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sectionTitle('Distance', Icons.place),
          const SizedBox(height: 8),
          Slider(
            value: distance,
            max: 30,
            divisions: 30,
            label: distance.round().toString(),
            onChanged: (double value) {
              setState(() => distance = value);
            },
          ),
          Text(
            '${distance.round()} km',
            style: TextStyle(
              color: GlobalStyles.filterColorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
