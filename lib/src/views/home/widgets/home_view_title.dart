import 'package:flutter/material.dart';

import 'package:babysitterapp/src/models.dart';

Widget homeViewTitle(UserAccount? user) {
  if (user == null) {
    return const Text('Guest Mode');
  }
  if (user.role != 'Client') {
    return const Text('Dashboard');
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Hello ${user.name}!',
      ),
    ],
  );
}
