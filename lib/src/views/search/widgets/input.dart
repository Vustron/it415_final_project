import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';

Widget searchButtons(TextEditingController searchTxt) => CustomTextInput(
      controller: searchTxt,
      onChanged: (String value) {},
      onClear: () {},
      prefixIcon: const Icon(Icons.search),
      hintText: 'Search...',
      fieldLabel: 'Search...',
      textInputAction: TextInputAction.next,
    );
