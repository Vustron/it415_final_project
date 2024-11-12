import 'package:flutter/material.dart';

// import 'package:babysitterapp/models/user_account.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    // final UserAccount user;
    return const Row(
      children: <Widget>[
        SizedBox(width: 18),
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 35,
        ),
        SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ratings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'no ratings yet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
