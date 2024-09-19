import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  const CustomInputWidget(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      this.isPass = false,
      required this.txtType,
      required this.labelTxt});
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final TextInputType txtType;
  final String labelTxt;

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inpBd = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      onSubmitted: (String value) {
        FocusManager.instance.primaryFocus?.unfocus(); // dismiss the keyboard
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
          contentPadding: const EdgeInsets.all(8)),
    );
  }
}
