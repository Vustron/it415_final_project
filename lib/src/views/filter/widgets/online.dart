import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

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
            activeColor: GlobalStyles.primaryButtonColor,
          ),
        ],
      ),
    );
  }
}
