import 'package:flutter/material.dart';
import 'package:babysitterapp/core/constants/styles.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    super.key,
    required this.onChanged,
    this.onClear,
    this.hintText = 'Enter text...',
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.borderRadius = 20.0,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.initialValue,
  });

  final void Function(String) onChanged;
  final VoidCallback? onClear;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;
  final String? initialValue;

  @override
  CustomTextInputState createState() => CustomTextInputState();
}

class CustomTextInputState extends State<CustomTextInput> {
  late TextEditingController _controller;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(_updateClearButtonVisibility);
  }

  void _updateClearButtonVisibility() {
    setState(() {
      _showClearButton = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateClearButtonVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintColor ?? Colors.grey.shade600),
        prefixIcon: widget.prefixIcon,
        suffixIcon: _showClearButton && widget.onClear != null
            ? IconButton(
                icon: Icon(Icons.clear,
                    color: widget.hintColor ?? Colors.grey.shade600),
                onPressed: () {
                  _controller.clear();
                  widget.onClear!();
                },
              )
            : widget.suffixIcon,
        filled: true,
        fillColor: widget.fillColor ?? Colors.grey.shade100,
        contentPadding: widget.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
              color: widget.focusedBorderColor ?? GlobalStyles.buttonColor),
        ),
      ),
      style: TextStyle(color: widget.textColor ?? Colors.grey.shade800),
      cursorColor: widget.cursorColor ?? GlobalStyles.buttonColor,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
    );
  }
}
