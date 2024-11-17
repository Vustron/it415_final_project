import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

class ReviewsInfoPage extends StatelessWidget with GlobalStyles {
  ReviewsInfoPage({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const CircleAvatar(
              backgroundImage: AssetImage(avatar1),
              radius: 50 / 2,
            ),
            const SizedBox(
              width: GlobalStyles.smallPadding,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Courtney Henry',
                  style: labelStyle,
                ),
                Row(
                  children: <Widget>[
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text('5.0'),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text(
                      '•',
                    ),
                    const SizedBox(
                      width: GlobalStyles.smallPadding,
                    ),
                    const Text('2 mins ago'),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        Text(
          'Content',
          style: labelStyle,
        ),
        const SizedBox(
          height: GlobalStyles.smallPadding,
        ),
        // Row(
        //   children: [
        //     Container(
        //       width: 50,
        //       height: 50,
        //       color: Colors.red,
        //     ),
        //     Container(
        //       width: 50,
        //       height: 50,
        //       color: Colors.red,
        //     ),
        //     Container(
        //       width: 50,
        //       height: 50,
        //       color: Colors.red,
        //     ),
        //   ],
        // ),

        SizedBox(
          height: height * 0.15,
          child: GridView.count(
            controller: _scrollController,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              Image.asset(logo),
              Image.asset(avatar1),
              Image.asset(avatar2),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(
          height: GlobalStyles.defaultPadding,
        ),
      ],
    );
  }
}
