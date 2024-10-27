// flutter
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/profile/edit_profile.dart';
import 'package:babysitterapp/views/booking/view.dart';
import 'package:babysitterapp/views/message/message.dart';
import 'package:babysitterapp/views/home/home.dart';

// view list
List<Widget> screens = const <Widget>[
  HomeView(),
  MessageView(),
  BookingView(),
  EditProfile(),
];
