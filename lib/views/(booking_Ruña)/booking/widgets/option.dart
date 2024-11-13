import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

Widget buildAddressOption(String label, String address, String selectedAddress,
    void Function(String) onAddressSelected) {
  final bool isSelected = selectedAddress == label;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? GlobalStyles.primaryButtonColor : Colors.grey[300]!,
        width: 2,
      ),
      color: isSelected
          ? GlobalStyles.primaryButtonColor.withOpacity(0.1)
          : Colors.white,
    ),
    child: InkWell(
      onTap: () => onAddressSelected(label),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Radio<String>(
              value: label,
              groupValue: selectedAddress,
              onChanged: (String? value) => onAddressSelected(value!),
              activeColor: GlobalStyles.primaryButtonColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: nexaExtraLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                      fontFamily: nexaExtraLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Implement see on map functionality
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: GlobalStyles.primaryButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.map),
              label: const Text('Map'),
            ),
          ],
        ),
      ),
    ),
  );
}
