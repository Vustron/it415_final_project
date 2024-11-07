// flutter

import 'package:babysitterapp/views/(settings_JK_Gerald)/babysitter_profile/account/view.dart';

import 'package:flutter/material.dart';

// views

import 'package:babysitterapp/views/(home_Macas_Millan)/message/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home/view.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/notification/view.dart';

// view list
final List<Widget> screens = <Widget>[
  const HomeView(),
  const MessageView(),
  const NotificationView(),
  const AccountView(),
];
