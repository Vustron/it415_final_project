// import 'package:babysitterapp/controllers/auth_controller.dart';
// import 'package:babysitterapp/core/state/authentication_state.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/views/(settings_JK_Gerald)/account/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/notification_client/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/message/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home/view.dart';

//required Hot reload to see changes
final List<Widget> screens = <Widget>[
  HomeView(),
  MessageView(),
  NotificationView(),
  AccountView(),
];
