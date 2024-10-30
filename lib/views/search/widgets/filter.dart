// third party
import 'package:hugeicons/hugeicons.dart';

// core
import 'package:babysitterapp/core/helper/goto_page.dart';

// flutter
import 'package:flutter/material.dart';

// views
import 'package:babysitterapp/views/filter/view.dart';

Widget buttons(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            label: const Text(
              'Maps',
            ),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedMaps,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              goToPage(context, const FilterView(), 'rightToLeftWithFade');
            },
            label: const Text(
              'Filter',
            ),
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedSorting01,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
