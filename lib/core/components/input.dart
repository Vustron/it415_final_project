// core
import 'package:babysitterapp/core/constants/styles.dart';

// flutter
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    super.key,
    required this.onChanged,
    this.onClear,
    this.controller,
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
    this.contentPadding = GlobalStyles.defaultContentPadding,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.initialValue,
  });

  final void Function(String) onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
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
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.addListener(_updateClearButtonVisibility);
  }

  void _updateClearButtonVisibility() {
    setState(() {
      _showClearButton = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration:  InputDecoration(
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
        fillColor: widget.fillColor ?? GlobalStyles.defaultFillColor,
        contentPadding: widget.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.borderColor ?? GlobalStyles.defaultBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? GlobalStyles.defaultFocusedBorderColor),
        ),
      ),
      style: TextStyle(color: widget.textColor ?? Colors.grey.shade800),
      cursorColor: widget.cursorColor ?? GlobalStyles.defaultFocusedBorderColor,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
    );
  }
}
