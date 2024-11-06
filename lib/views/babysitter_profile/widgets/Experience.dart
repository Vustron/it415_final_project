import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/widgets.dart';

class ExperiencePage extends StatelessWidget with GlobalStyles {
  ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD0D0D0),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: GlobalStyles.defaultContentPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Experience',
            style: labelStyle,
          ),
          Text(
            '4 Years',
            style: labelStyle,
          ),
        ],
      ),
    );
  }
}
