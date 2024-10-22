// third party
import 'package:getwidget/getwidget.dart';
import 'package:hugeicons/hugeicons.dart';

// flutter
import 'package:flutter/material.dart';

Widget requestButton() => GFIconButton(
      onPressed: () {},
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedTimeSchedule,
        color: Colors.white,
      ),
      color: const Color(0xFF1686AA),
    );
