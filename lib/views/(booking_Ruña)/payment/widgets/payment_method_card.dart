import 'package:babysitterapp/core/constants.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentMethodOption method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? GlobalStyles.primaryButtonColor
              : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      elevation: isSelected ? 4 : 2,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? GlobalStyles.primaryButtonColor.withOpacity(0.1)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            method.icon,
            size: 24,
            color: isSelected
                ? GlobalStyles.primaryButtonColor
                : Colors.grey.shade700,
          ),
        ),
        title: Text(
          method.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color:
                isSelected ? GlobalStyles.primaryButtonColor : Colors.black87,
          ),
        ),
        subtitle: Text(
          method.description,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 13,
          ),
        ),
        trailing: Radio<bool>(
          value: true,
          groupValue: isSelected,
          onChanged: (_) => onTap(),
          activeColor: GlobalStyles.primaryButtonColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
