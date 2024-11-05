import 'package:babysitterapp/core/constants/styles.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/AvailabilityInfo.dart';
import 'package:babysitterapp/views/babysitter_profile/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';

class AvailabilityPage extends StatelessWidget with GlobalStyles {
  AvailabilityPage({super.key});

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
            text: 'Availability',
          ),
          AvailabilityinfoPage(),
          AvailabilityinfoPage(),
          AvailabilityinfoPage(),
          AvailabilityinfoPage(),
        ],
      ),
    );
  }
}
