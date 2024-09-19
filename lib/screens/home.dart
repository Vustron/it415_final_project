// utils
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: const HugeIcon(
          icon: HugeIcons.strokeRoundedUserCircle,
          color: Colors.black,
          size: 35,
        ),
        centerTitle: false,
        title: const Text(
          'Hello User',
          style: TextStyle(color: Colors.black),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HugeIcon(
                  icon: HugeIcons.strokeRoundedMessageMultiple02,
                  color: Colors.black,
                  size: 35,
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HomeScreen'),
          ],
        ),
      ),
    );
  }
}
