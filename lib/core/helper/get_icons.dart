// third party
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

// flutter
import 'package:flutter/material.dart';

IconData getIcon(int index, bool isSelected) {
  switch (index) {
    case 0:
      return isSelected
          ? FluentIcons.home_12_filled
          : FluentIcons.home_12_regular;
    case 1:
      return isSelected
          ? FluentIcons.chat_12_filled
          : FluentIcons.chat_12_regular;
    case 2:
      return isSelected
          ? FluentIcons.alert_12_filled
          : FluentIcons.alert_12_regular;
    case 3:
      return isSelected
          ? FluentIcons.person_12_filled
          : FluentIcons.person_12_regular;
    default:
      return FluentIcons.home_12_regular;
  }
}
