import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';
import 'package:babysitterapp/src/models.dart';

class AddressField extends HookConsumerWidget {
  const AddressField({
    super.key,
    required this.name,
    required this.decoration,
    this.initialValue,
    this.initialLatitude,
    this.initialLongitude,
  });

  final String name;
  final InputDecoration decoration;
  final String? initialValue;
  final String? initialLatitude;
  final String? initialLongitude;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller =
        useTextEditingController(text: initialValue);
    final LocationRepository location = ref.watch(locationService);
    final LocationController locationController =
        ref.watch(locationControllerService.notifier);

    // Set initial values for latitude and longitude
    useEffect(() {
      if (initialLatitude != null && initialLongitude != null) {
        final FormBuilderState? form = FormBuilder.of(context);
        if (form?.mounted ?? false) {
          form?.fields['Address Latitude']?.didChange(initialLatitude);
          form?.fields['Address Longitude']?.didChange(initialLongitude);
        }
      }
      return null;
    }, const <Object?>[]);

    return Row(
      children: <Widget>[
        Expanded(
          child: FormBuilderTextField(
            name: name,
            controller: controller,
            decoration: decoration,
            onChanged: (String? value) {
              final FormBuilderState? form = FormBuilder.of(context);
              if (form?.mounted ?? false) {
                form?.fields['Address Latitude']?.didChange('');
                form?.fields['Address Longitude']?.didChange('');
              }
            },
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
              final String address =
                  await location.getAddressFromCoordinates(selectedLocation);

              final NominatimAPI? locationData = await locationController
                  .getLongitudeAndLatitude(selectedLocation);

              if (!context.mounted) return;

              controller.text = address;

              final FormBuilderState? form = FormBuilder.of(context);
              if (form?.mounted ?? false) {
                form?.save();
                form?.fields[name]?.didChange(address);
                form?.fields['Address Latitude']?.didChange(locationData?.lat);
                form?.fields['Address Longitude']?.didChange(locationData?.lon);
              }
            }
          },
        ),
      ],
    );
  }
}
