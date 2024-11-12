import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

import 'package:babysitterapp/views/settings.dart';

class AvailabilityView extends HookConsumerWidget with GlobalStyles {
  AvailabilityView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          SectionLabel(
            text: 'Availability',
          ),
          Info(),
          Info(),
          Info(),
          Info(),
        ],
      ),
    );
  }
}
