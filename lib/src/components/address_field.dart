import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/models.dart';

class AddressField extends HookConsumerWidget {
  const AddressField({
    super.key,
    required this.name,
    required this.decoration,
    this.initialValue,
  });

  final String name;
  final InputDecoration decoration;
  final String? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller =
        useTextEditingController(text: initialValue);
    final LocationRepository locationService =
        ref.watch(locationRepositoryProvider);
    final LocationController locationController =
        ref.watch(locationControllerProvider.notifier);

    return Row(
      children: <Widget>[
        Expanded(
          child: FormBuilderTextField(
            name: name,
            controller: controller,
            decoration: decoration,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.map),
          onPressed: () async {
            final LatLng? selectedLocation = await Navigator.push<LatLng>(
              context,
              MaterialPageRoute<LatLng>(
                builder: (BuildContext context) => const MapScreen(),
              ),
            );

            if (selectedLocation != null) {
              final String address = await locationService
                  .getAddressFromCoordinates(selectedLocation);

              final NominatimAPI? locationData = await locationController
                  .getLongitudeAndLatitude(selectedLocation);

              controller.text = address;

              if (context.mounted && locationData != null) {
                final FormBuilderState? form = FormBuilder.of(context);

                form?.save();
                form?.fields[name]?.didChange(address);
                form?.fields['Address Latitude']?.didChange(locationData.lat);
                form?.fields['Address Longitude']?.didChange(locationData.lon);
              }
            }
          },
        ),
      ],
    );
  }
}
