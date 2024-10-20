// utils
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:babysitterapp/core/helper/goto_page.dart';
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/core/widgets/home/toprate_sitter_card.dart';
import 'package:babysitterapp/core/widgets/home/toprated_babysitter.dart';
import 'package:babysitterapp/core/widgets/home/babysitter_nearby.dart';
import 'package:babysitterapp/core/widgets/home/horizontal_scroll.dart';

// views
import 'package:babysitterapp/views/home/notification.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              goToPage(
                  context, const NotificationView(), 'rightToLeftWithFade');
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
