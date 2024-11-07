import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';

import 'widgets/map_screen.dart';
import 'widgets/input.dart';

import 'package:babysitterapp/views/(search_Layao)/filter/view.dart';

class SearchView extends HookWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
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
                goToPage(context, const FilterView(), 'rightToLeftWithFade');
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
