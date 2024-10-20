// core
import 'price_dropdown.dart';
import 'section_title.dart';
import 'card.dart';

// flutter
import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  PriceFilterState createState() => PriceFilterState();
}

class PriceFilterState extends State<PriceFilter> {
  String minPrice = '₱500.00';
  String maxPrice = '₱2500.00';

  @override
  Widget build(BuildContext context) {
    return filterCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sectionTitle('Price', Icons.attach_money),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: priceDropdown(
                  value: minPrice,
                  items: <String>[
                    '₱500.00',
                    '₱1000.00',
                    '₱1500.00',
                    '₱2000.00'
                  ],
                  onChanged: (String? newValue) {
                    setState(() => minPrice = newValue!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: priceDropdown(
                  value: maxPrice,
                  items: <String>[
                    '₱2500.00',
                    '₱3000.00',
                    '₱3500.00',
                    '₱4000.00'
                  ],
                  onChanged: (String? newValue) {
                    setState(() => maxPrice = newValue!);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
