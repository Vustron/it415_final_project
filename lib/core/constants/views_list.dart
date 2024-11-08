import 'package:flutter/material.dart';

import 'package:babysitterapp/views/(settings_JK_Gerald)/profile/account/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/notification/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/message/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home/view.dart';

final List<Widget> screens = <Widget>[
  HomeView(),
  const MessageView(),
  const NotificationView(),
  const AccountView(),
];
