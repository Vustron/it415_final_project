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
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/placeholder_logo.png'),
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Hello Arvin Sison!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedMessageMultiple02,
              color: Colors.black,
              size: 31,
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
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
