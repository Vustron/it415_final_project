import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class HomeBabysitterView extends StatefulWidget {
  const HomeBabysitterView({
    super.key,
    required this.username,
    required this.userImg,
    required this.location,
  });

  final String username, userImg, location;

  @override
  State<HomeBabysitterView> createState() => _HomeBabysitterViewState();
}

class _HomeBabysitterViewState extends State<HomeBabysitterView> {
  List<String> photoList = <String>[
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
  ];

  final List<Map<String, String>> comments = <Map<String, String>>[
    <String, String>{
      'name': 'John Doe',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'This is a great post!',
      'time': '2h ago'
    },
    <String, String>{
      'name': 'Jane Smith',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'I completely agree with your points.',
      'time': '3h ago'
    },
    <String, String>{
      'name': 'Sam Wilson',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'Thanks for sharing this information.',
      'time': '5h ago'
    },
    <String, String>{
      'name': 'Emily Davis',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'Very insightful!',
      'time': '1d ago'
    },
    <String, String>{
      'name': 'Michael Brown',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'Can you provide more details?',
      'time': '2d ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: <Widget>[
            babySitterHeader(
              username: widget.username,
              networkImage: widget.userImg,
              starRatings: '5.0',
              location: widget.location,
            ),
            barGraphBabySitter(colorBar: GlobalStyles.primaryButtonColor),
            cardPageBabySitter(),
            titleHeaderBabySitter('Photos', () {}, false),
            photoRow(context, photoList, () {}),
            titleHeaderBabySitter('Comments', () {}, true),
            commentList(comments),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
