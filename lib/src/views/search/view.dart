import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:babysitterapp/src/views.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchTxt = useTextEditingController();
    final MarkerData? selectedMarker = ref.watch(selectedMarkerService);

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    FluentIcons.arrow_left_24_regular,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: GlobalStyles.smallPadding),
                Expanded(child: searchButtons(searchTxt))
              ],
            ),
          ),
          if (selectedMarker == null)
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
    );
  }
}
