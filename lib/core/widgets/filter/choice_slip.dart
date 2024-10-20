// utils
import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter/material.dart';

class ChoiceSlip extends StatefulWidget {
  const ChoiceSlip({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  ChoiceSlipState createState() => ChoiceSlipState();
}

class ChoiceSlipState extends State<ChoiceSlip> {
  String? sortBy;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(widget.icon,
              size: 18,
              color: sortBy == widget.label
                  ? GlobalStyles.filterColorScheme.onSecondary
                  : GlobalStyles.filterColorScheme.onSurface),
          const SizedBox(width: 4),
          Text(widget.label),
        ],
      ),
      selected: sortBy == widget.label,
      onSelected: (bool selected) {
        setState(() => sortBy = selected ? widget.label : null);
      },
      selectedColor: GlobalStyles.filterColorScheme.secondary,
      backgroundColor: GlobalStyles.filterColorScheme.surface,
    );
  }
}
