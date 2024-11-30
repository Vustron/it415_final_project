import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.symbol = '₱', this.decimalPlaces = 2});

  final String symbol;
  final int decimalPlaces;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String value = newValue.text
        .replaceAll(symbol, '')
        .replaceAll(',', '')
        .replaceAll(' ', '');

    if (value == '.') {
      value = '0.';
    }

    if (!RegExp(r'^\d*\.?\d*$').hasMatch(value)) {
      return oldValue;
    }

    // Split number into integer and decimal parts
    final List<String> parts = value.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    if (decimalPart.length > decimalPlaces) {
      decimalPart = decimalPart.substring(0, decimalPlaces);
    }

    final double? number = double.tryParse(
        '${integerPart.isEmpty ? '0' : integerPart}${decimalPart.isEmpty ? '' : '.$decimalPart'}');

    if (number == null) {
      return oldValue;
    }

    integerPart = integerPart.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    String formatted = '$symbol$integerPart';
    if (value.contains('.') || decimalPart.isNotEmpty) {
      formatted += '.${decimalPart.padRight(decimalPlaces, '0')}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
