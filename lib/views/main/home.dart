// utils
import 'package:babysitterapp/views/main/notification.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/widgets/home/toprate_sitter_card.dart';
import 'package:babysitterapp/widgets/home/toprated_babysitter.dart';
import 'package:babysitterapp/widgets/home/babysitter_nearby.dart';
import 'package:babysitterapp/widgets/home/horizontal_scroll.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
              color: Colors.black, fontSize: 20, fontFamily: 'Nexa-Heavy'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
            icon: const Icon(
              FluentIcons.alert_12_regular,
              color: Colors.black,
              size: 31,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: <Widget>[
                  titleBabySitterNearby(),
                  scrollHorizontal(),
                  titleTopRatedBabySitter(),
                  topRatedBabySitterCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
