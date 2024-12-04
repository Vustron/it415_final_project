import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';

final StateProvider<String> searchQueryProvider =
    StateProvider<String>((StateProviderRef<String> ref) => '');

Widget searchButtons(TextEditingController searchTxt, WidgetRef ref) =>
    CustomTextInput(
      controller: searchTxt,
      onChanged: (String value) {
        ref.read(searchQueryProvider.notifier).state = value.toLowerCase();
      },
      onClear: () {
        searchTxt.clear();
        ref.read(searchQueryProvider.notifier).state = '';
      },
      prefixIcon: const Icon(Icons.search),
      hintText: 'Search babysitter name...',
      fieldLabel: 'Search...',
      textInputAction: TextInputAction.search,
      fillColor: Colors.white,
    );
