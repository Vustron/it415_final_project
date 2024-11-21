import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  PriceFilterState createState() => PriceFilterState();
}

class PriceFilterState extends State<PriceFilter> {
  double price = 100;

  @override
  Widget build(BuildContext context) {
    return filterCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sectionTitle('Price', Icons.attach_money),
          const SizedBox(height: 8),
          Slider(
            value: price,
            max: 3000,
            divisions: 30,
            label: price.round().toString(),
            onChanged: (double value) {
              setState(() => price = value);
            },
          ),
          Text(
            '₱ ${price.round()}',
            style: TextStyle(
              color: GlobalStyles.filterColorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
