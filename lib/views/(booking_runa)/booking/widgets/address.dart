// core
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

// widgets
import 'option.dart';

Widget buildAddressSection(
    String selectedAddress, void Function(String) onAddressSelected) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Row(
        children: <Widget>[
          Icon(Icons.location_on, color: GlobalStyles.primaryButtonColor),
          SizedBox(width: 8),
          Text(
            'Select Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: GlobalStyles.primaryButtonColor,
              fontFamily: nexaExtraLight,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      buildAddressOption('Home', 'Panabo city, Davao del Norte',
          selectedAddress, onAddressSelected),
      const SizedBox(height: 12),
      buildAddressOption('Work', 'Panabo city, Davao del Norte',
          selectedAddress, onAddressSelected),
    ],
  );
}
