import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/helpers.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchTxt = useTextEditingController();
    final MarkerData? selectedMarker = ref.watch(selectedMarkerService);
    final LocationState locationState = ref.watch(locationControllerService);
    final AsyncValue<void> locationInit = ref.watch(locationInitProvider);

    useEffect(() {
      locationInit.whenOrNull(
        error: (Object error, StackTrace stack) {
          if (!context.mounted) return;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final bool isLocationDisabled =
                error.toString().contains('Location services are disabled');

            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                title: Text(isLocationDisabled
                    ? 'Location Services Disabled'
                    : 'Location Access Required'),
                content: Text(isLocationDisabled
                    ? 'Please enable location services to use this feature'
                    : error.toString()),
                actions: <Widget>[
                  if (isLocationDisabled)
                    TextButton(
                      onPressed: () async {
                        await Geolocator.openLocationSettings();
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ref.read(locationInitProvider.notifier).initialize();
                      },
                      child: const Text('Open Settings'),
                    ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(isLocationDisabled ? 'Cancel' : 'OK'),
                  ),
                ],
              ),
            );
          });
        },
      );
      return null;
    }, <Object?>[locationInit]);

    return Scaffold(
      body: VerificationGuard(
        user: ref.watch(authControllerService).user,
        child: Stack(
          children: <Widget>[
            if (locationInit.isLoading || locationState.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: GlobalStyles.primaryButtonColor,
                ),
              )
            else if (locationInit.hasError || locationState.error != null)
              Center(
                child: Text(
                  'Error: ${locationInit.hasError ? locationInit.error : locationState.error}',
                ),
              )
            else
              const SearchMapScreen(),
            Container(
              margin: const EdgeInsets.only(top: 30),
              color: const Color.fromARGB(0, 143, 43, 43),
              padding: GlobalStyles.defaultContentPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      FluentIcons.arrow_left_24_regular,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: GlobalStyles.smallPadding),
                  Expanded(
                    child: searchButtons(
                      searchTxt,
                      ref,
                    ),
                  ),
                ],
              ),
            ),
            if (selectedMarker == null && !locationState.isLoading)
              Positioned(
                bottom: 60,
                right: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'distance',
                      backgroundColor: GlobalStyles.primaryButtonColor,
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) =>
                              const DistanceBottomSheet(),
                        );
                      },
                      child: const Icon(
                        FluentIcons.arrow_autofit_content_24_filled,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
