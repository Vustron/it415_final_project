import 'package:flutter/material.dart';

import 'package:babysitterapp/views/settings.dart';
import 'package:babysitterapp/views/home.dart';

//required Hot reload to see changes
final List<Widget> screens = <Widget>[
  HomeClientView(),
  MessageView(),
  NotificationView(),
  AccountView(),
];
