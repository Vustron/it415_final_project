import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

Future<Widget> buildAddressOption(
  String label,
  String address,
  LatLng? location,
  String selectedAddress,
  void Function(String label, String address, LatLng? location)
      onAddressSelected,
  BuildContext context,
  UserAccount user,
) async {
  final bool isSelected = selectedAddress == label;
  final String displayAddress =
      (await getAddressFromLocation(location)) ?? address;

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
      onTap: () async => onAddressSelected(
        label,
        displayAddress,
        location,
      ),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Radio<String>(
              value: label,
              groupValue: selectedAddress,
              onChanged: (String? value) async => onAddressSelected(
                value!,
                (await getAddressFromLocation(location)) ?? address,
                location,
              ),
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
                    displayAddress,
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
                CustomRouter.navigateToWithTransition(
                  MapView(
                    onLocationSelected: (String newAddress, LatLng location) {
                      onAddressSelected(
                        label,
                        newAddress,
                        location,
                      );
                    },
                    user: user,
                  ),
                  'fade',
                );
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
