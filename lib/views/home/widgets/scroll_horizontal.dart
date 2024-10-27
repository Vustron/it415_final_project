// core
import 'card_nearby.dart';

// flutter
import 'package:flutter/material.dart';

Widget scrollHorizontal() => SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return babySitterCardNearby();
        },
      ),
    );
