import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';
import 'package:babysitterapp/core/helpers.dart';

import 'package:babysitterapp/views/search.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchTxt = useTextEditingController();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const MapScreen(),
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
                const SizedBox(
                  width: GlobalStyles.smallPadding,
                ),
                Expanded(
                  child: searchButtons(searchTxt),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: FloatingActionButton.extended(
              backgroundColor: GlobalStyles.primaryButtonColor,
              foregroundColor: Colors.white,
              onPressed: () {
                if (!Navigator.of(context).canPop()) {
                  goToPage(context, FilterView(), 'rightToLeftWithFade');
                }
              },
              label: const Text('Filter'),
              icon: const Icon(
                FluentIcons.filter_24_regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
