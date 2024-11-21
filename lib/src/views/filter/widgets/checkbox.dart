import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class AdditionCheckbox extends StatefulWidget {
  const AdditionCheckbox({super.key});

  @override
  AdditionCheckboxState createState() => AdditionCheckboxState();
}

class AdditionCheckboxState extends State<AdditionCheckbox> {
  final List<String> additions = <String>[
    'Without bad habits',
    'Knows how to give first aid',
    'Multitasking and stress resistant',
    'Has own baby monitor',
    'Super ability to swaddle in the air',
    'Can take out the trash',
  ];

  final List<String> additions_ = <String>[
    'Multitasking and stress resistant',
    'Super ability to swaddle in the air'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: additions.map((String addition) {
        return CheckboxListTile(
          title: Text(addition,
              style: TextStyle(
                  color: GlobalStyles.filterColorScheme.onBackground)),
          value: additions_.contains(addition),
          onChanged: (bool? value) {
            setState(() {
              if (value!) {
                additions_.add(addition);
              } else {
                additions_.remove(addition);
              }
            });
          },
          activeColor: GlobalStyles.primaryButtonColor,
        );
      }).toList(),
    );
  }
}
