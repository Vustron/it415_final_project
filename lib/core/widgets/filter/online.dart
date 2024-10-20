// utils
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

// widgets
import 'section_title.dart';
import 'card.dart';

class OnlineNowSwitch extends StatefulWidget {
  const OnlineNowSwitch({super.key});

  @override
  OnlineNowSwitchState createState() => OnlineNowSwitchState();
}

class OnlineNowSwitchState extends State<OnlineNowSwitch> {
  bool onlineNow = false;

  @override
  Widget build(BuildContext context) {
    return filterCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          sectionTitle('Online now', Icons.wifi),
          Switch(
            value: onlineNow,
            onChanged: (bool value) {
              setState(() => onlineNow = value);
            },
            activeColor: GlobalStyles.filterColorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
