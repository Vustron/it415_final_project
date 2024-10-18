// utils

import 'package:flutter/material.dart';

// screens
import 'package:babysitterapp/views/main/edit_profile.dart';
import 'package:babysitterapp/views/main/booking.dart';
import 'package:babysitterapp/views/main/message.dart';
import 'package:babysitterapp/views/main/home.dart';

// screen list
List<Widget> screens = const <Widget>[
  HomeScreen(),
  MessageScreen(),
  BookingScreen(),
  EditProfile(),
];
