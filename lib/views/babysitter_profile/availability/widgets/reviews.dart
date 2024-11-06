import 'package:babysitterapp/core/constants/styles.dart';

import 'package:babysitterapp/views/babysitter_profile/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'review_info.dart';

class ReviewsPage extends StatelessWidget with GlobalStyles {
  ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D0D0),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: GlobalStyles.defaultContentPadding,
      child: Column(
        children: <Widget>[
          SectionTitle(
            text: 'Reviews',
          ),
          const SizedBox(
            height: GlobalStyles.defaultPadding,
          ),
          ReviewsInfoPage(),
          ReviewsInfoPage(),
          ReviewsInfoPage(),
          ReviewsInfoPage(),
        ],
      ),
    );
  }
}
