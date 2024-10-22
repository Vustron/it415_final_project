// utils
import 'package:babysitterapp/core/widgets/search/filter.dart';
import 'package:babysitterapp/core/widgets/search/input.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/search/search_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTxt = TextEditingController();

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
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Search',
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            searchButtons(searchTxt),
            const SizedBox(
              height: 5.0,
            ),
            buttons(context),
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
