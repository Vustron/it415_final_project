// flutter

import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/settings/widgets/profile_info.dart';
import 'package:babysitterapp/views/booking/view.dart';
import 'package:babysitterapp/views/message/view.dart';
import 'package:babysitterapp/views/home/view.dart';

// view list
List<Widget> screens = const <Widget>[
  HomeView(),
  MessageView(),
  BookingView(),
  ProfileInfo(),
];
