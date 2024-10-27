// core
import 'package:babysitterapp/core/constants/assets.dart';
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

Widget buildChildrenSelector(BuildContext context, int? numberOfChildren,
    void Function(BuildContext) showChildrenSelectionDialog) {
  return InkWell(
    onTap: () => showChildrenSelectionDialog(context),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: GlobalStyles.primaryButtonColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GlobalStyles.primaryButtonColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              numberOfChildren == null
                  ? 'Choose the number of children'
                  : '$numberOfChildren ${numberOfChildren == 1 ? 'child' : 'children'}',
              style: const TextStyle(
                color: GlobalStyles.primaryButtonColor,
                fontFamily: nexaExtraLight,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_drop_down,
              color: GlobalStyles.primaryButtonColor),
        ],
      ),
    ),
  );
}
