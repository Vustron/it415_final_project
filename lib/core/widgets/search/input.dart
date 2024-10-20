// core
import 'package:babysitterapp/core/widgets/ui/input.dart';

// flutter
import 'package:flutter/material.dart';

Widget searchButtons(TextEditingController searchTxt) => CustomInputWidget(
    textEditingController: searchTxt,
    hintText: '',
    txtType: TextInputType.text,
    labelTxt: 'Search');
