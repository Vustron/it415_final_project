// flutter
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:babysitterapp/views/(search_Layao)/filter/view.dart';
import 'package:babysitterapp/views/(search_Layao)/search/widgets/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

// widgets
import 'widgets/input.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    Icons.arrow_back,
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
                setState(() {
                  goToPage(context, const FilterView(), 'rightToLeftWithFade');
                });
              },
              label: const Text('Filter'),
              icon: const Icon(
                HugeIcons.strokeRoundedSorting01,
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 95),
          //   padding: GlobalStyles.defaultContentPadding,
          //   child: searchButtons(searchTxt),
          // )
        ],
      ),
    );
  }
}
