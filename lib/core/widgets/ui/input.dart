// flutter
import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget({
    required this.textEditingController,
    required this.hintText,
    required this.txtType,
    required this.labelTxt,
    this.isPass = false,
    super.key,
  });

  final TextEditingController textEditingController;
  final TextInputType txtType;
  final String hintText;
  final String labelTxt;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inpBd = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      onSubmitted: (String value) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: isPass,
      controller: textEditingController,
      keyboardType: txtType,
      decoration: InputDecoration(
        labelText: labelTxt,
        border: inpBd,
        focusedBorder: inpBd,
        enabledBorder: inpBd,
        hintText: hintText,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
