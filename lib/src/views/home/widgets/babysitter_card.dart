import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/views.dart';

Widget cardPageBabySitter() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: statsCard(
              icon: FluentIcons.money_24_regular,
              value: '10',
              label: 'No. of transaction',
              gradientColors: <Color>[
                Colors.green.shade50,
                Colors.green.shade100,
              ],
              iconColor: Colors.green.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: statsCard(
              icon: FluentIcons.person_24_regular,
              value: '10',
              label: 'No. of BabySitting',
              gradientColors: <Color>[
                Colors.blue.shade50,
                Colors.blue.shade100,
              ],
              iconColor: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
