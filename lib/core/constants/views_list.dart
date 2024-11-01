// flutter

import 'package:babysitterapp/views/babysitter_profile/account/view.dart';
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/booking/view.dart';
import 'package:babysitterapp/views/message/view.dart';
import 'package:babysitterapp/views/home/view.dart';

// view list
List<Widget> screens = const <Widget>[
  HomeView(),
  MessageView(),
  BookingView(),
  AccountView(),
];
