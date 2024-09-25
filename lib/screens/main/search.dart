import 'package:flutter/material.dart';

class SearchApp extends StatefulWidget {
  const SearchApp({super.key});

  @override
  State<SearchApp> createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {
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
    );
  }
}
