import 'package:flutter/material.dart';

enum PaymentMethod { cashOnService, gPay }

class PaymentMethodOption {
  PaymentMethodOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.method,
  });

  final String title;
  final String description;
  final IconData icon;
  final PaymentMethod method;
}
