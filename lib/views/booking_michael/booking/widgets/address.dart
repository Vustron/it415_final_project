import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/controllers/auth_controller.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/state.dart';

import 'package:babysitterapp/models/models.dart';

import 'package:babysitterapp/views/booking.dart';

Widget buildAddressSection(
  BuildContext context,
  WidgetRef ref,
  String selectedAddress,
  void Function(String, String, LatLng?) onAddressSelected,
) {
  final AuthenticationState authState = ref.watch(authController);

  return authState.maybeWhen(
    authenticated: (UserAccount user) => Column(
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
        FutureBuilder<Widget>(
          future: buildAddressOption(
            'Home',
            'Panabo city, Davao del Norte',
            null,
            selectedAddress,
            onAddressSelected,
            context,
            user,
          ),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return snapshot.data!;
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(height: 12),
        FutureBuilder<Widget>(
          future: buildAddressOption(
            'Work',
            'Panabo city, Davao del Norte',
            null,
            selectedAddress,
            onAddressSelected,
            context,
            user,
          ),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return snapshot.data!;
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    ),
    orElse: () => const Center(
      child: Text('Please login to select address'),
    ),
  );
}
