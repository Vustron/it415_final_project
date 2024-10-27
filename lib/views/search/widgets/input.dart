// core
import 'package:babysitterapp/core/components/ui/input.dart';

// flutter
import 'package:flutter/material.dart';

Widget searchButtons(TextEditingController searchTxt) => CustomTextInput(
      controller: searchTxt,
      onChanged: (String value) {},
      onClear: () {},
      prefixIcon: const Icon(Icons.search),
      hintText: 'Search...',
      textInputAction: TextInputAction.next,
    );
