// flutter

import 'package:babysitterapp/views/babysitter_profile/account/view.dart';

import 'package:flutter/material.dart';

// views

import 'package:babysitterapp/views/message/view.dart';
import 'package:babysitterapp/views/home/view.dart';
import 'package:babysitterapp/views/notification/view.dart';

// view list
final List<Widget> screens = <Widget>[
  const HomeView(),
  const MessageView(),
  const NotificationView(),
  const AccountView(),
];
