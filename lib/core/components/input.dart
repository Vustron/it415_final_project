import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants/styles.dart';

class CustomTextInput extends HookWidget {
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
    this.errorText,
    this.enabled = true,
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
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController = controller ??
        useTextEditingController(
          text: initialValue,
        );
    final ValueNotifier<bool> showClearButton = useState(false);

    useEffect(() {
      void updateClearButtonVisibility() {
        showClearButton.value = effectiveController.text.isNotEmpty;
      }

      effectiveController.addListener(updateClearButtonVisibility);
      return () =>
          effectiveController.removeListener(updateClearButtonVisibility);
    }, <Object?>[effectiveController]);

    return TextField(
      controller: effectiveController,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? Colors.grey.shade600),
        prefixIcon: prefixIcon,
        suffixIcon: showClearButton.value && onClear != null
            ? IconButton(
                icon:
                    Icon(Icons.clear, color: hintColor ?? Colors.grey.shade600),
                onPressed: () {
                  effectiveController.clear();
                  onClear!();
                },
              )
            : suffixIcon,
        filled: true,
        fillColor: fillColor ?? GlobalStyles.defaultFillColor,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
              color: errorText != null
                  ? Colors.red
                  : borderColor ?? GlobalStyles.defaultBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
              color: errorText != null
                  ? Colors.red
                  : focusedBorderColor ??
                      GlobalStyles.defaultFocusedBorderColor),
        ),
      ),
      style: TextStyle(color: textColor ?? Colors.grey.shade800),
      cursorColor: cursorColor ?? GlobalStyles.defaultFocusedBorderColor,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
    );
  }
}
