// core
import 'request_button.dart';
import 'user.dart';

// flutter
import 'package:flutter/material.dart';

Widget showSearched() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const SizedBox(
          width: 80,
          height: 80,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              'assets/images/hippo.png',
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 5,
          child: searchHeader(),
        ),
        requestButton()
      ],
    );
