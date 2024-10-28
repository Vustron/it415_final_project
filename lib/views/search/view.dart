// flutter
import 'package:flutter/material.dart';

// widgets
import 'widgets/search_list.dart';
import 'widgets/filter.dart';
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
