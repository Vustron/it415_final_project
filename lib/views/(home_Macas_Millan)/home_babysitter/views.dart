import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/card_page.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/comment_list.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/graph_page.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/header_page.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/photo_row.dart';
import 'package:babysitterapp/views/(home_Macas_Millan)/home_babysitter/widgets/title_header.dart';
import 'package:flutter/material.dart';

class DashboardBabySitter extends StatefulWidget {
  const DashboardBabySitter({
    super.key,
    required this.username,
    required this.userImg,
    required this.location,
  });
  final String username, userImg, location;

  @override
  State<DashboardBabySitter> createState() => _DashboardBabySitterState();
}

class _DashboardBabySitterState extends State<DashboardBabySitter> {
  List<String> photoList = <String>[
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
    'https://placehold.jp/150x150.png',
  ];

  final List<Map<String, String>> comments = <Map<String, String>>[
    {
      'name': 'John Doe',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'This is a great post!',
      'time': '2h ago'
    },
    {
      'name': 'Jane Smith',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'I completely agree with your points.',
      'time': '3h ago'
    },
    {
      'name': 'Sam Wilson',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'Thanks for sharing this information.',
      'time': '5h ago'
    },
    {
      'name': 'Emily Davis',
      'profileUrl': 'https://placehold.jp/150x150.png',
      'comment': 'Very insightful!',
      'time': '1d ago'
    },
    {
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
