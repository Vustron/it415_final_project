// utils
import 'package:flutter/material.dart';

// widget
import 'package:babysitterapp/core/widgets/home/babysitter_card_nearby.dart';

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
