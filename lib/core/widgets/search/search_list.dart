// core
import 'body.dart';

// flutter
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SingleChildScrollView(
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: <Widget>[
            for (int i = 0; i < 5; i++) ...<Widget>[
              const SizedBox(
                height: 10.0,
              ),
              showSearched(),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
