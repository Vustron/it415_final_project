import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:babysitterapp/src/models.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/views.dart';

class HomeBabysitterView extends HookWidget {
  const HomeBabysitterView({
    super.key,
    this.user,
  });

  final UserAccount? user;
  bool get isVerified =>
      user?.emailVerified != null && user?.validIdVerified != null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: Column(
          children: <Widget>[
            babySitterHeader(
              username: user?.name ?? '',
              networkImage: user?.profileImg ?? '',
              starRatings: '5.0',
              location: user?.address ?? '',
              onlineStatus: user?.onlineStatus ?? false,
              isVerified: isVerified,
            ),
            cardPageBabySitter(),
            const TransactionChart(colorBar: GlobalStyles.primaryButtonColor),
            const SizedBox(height: 145),
          ],
        ),
      ),
    );
  }
}
