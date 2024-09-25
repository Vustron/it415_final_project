// utils
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// screens
import 'filter.dart';

// actions
import 'package:babysitterapp/actions/navbar/goto_page.dart';

// widgets
import 'package:babysitterapp/widgets/shared/text_input.dart';
import 'package:babysitterapp/widgets/search/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTxt = TextEditingController();

  Widget searchButtons() => CustomInputWidget(
      textEditingController: searchTxt,
      hintText: '',
      txtType: TextInputType.text,
      labelTxt: 'Search');

  Widget buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Maps',
              style: TextStyle(
                  fontFamily: 'Nexa-ExtraLight',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedMaps,
              color: Colors.black,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              gotoPage(context, const FilterScreen());
            },
            label: const Text(
              'Filter',
              style: TextStyle(
                  fontFamily: 'Nexa-ExtraLight',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedSorting01,
              color: Colors.black,
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Search',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Nexa-Heavy'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            searchButtons(),
            const SizedBox(
              height: 5.0,
            ),
            buttons(),
            const SizedBox(
              height: 5.0,
            ),
            const SearchList(),
          ],
        ),
      ),
    );
  }
}
