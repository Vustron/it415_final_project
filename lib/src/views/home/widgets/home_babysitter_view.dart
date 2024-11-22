import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class HomeBabysitterView extends StatefulWidget {
  const HomeBabysitterView({
    super.key,
    required this.username,
    required this.userImg,
    required this.location,
    required this.onlineStatus,
  });

  final String username, userImg, location;
  final bool onlineStatus;

  @override
  State<HomeBabysitterView> createState() => _HomeBabysitterViewState();
}

class _HomeBabysitterViewState extends State<HomeBabysitterView> {
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
              onlineStatus: widget.onlineStatus,
            ),
            const TransactionChart(colorBar: GlobalStyles.primaryButtonColor),
            cardPageBabySitter(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
