// utils

import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/widgets/ui/input.dart';

Widget searchButtons(TextEditingController searchTxt) => CustomInputWidget(
    textEditingController: searchTxt,
    hintText: '',
    txtType: TextInputType.text,
    labelTxt: 'Search');
