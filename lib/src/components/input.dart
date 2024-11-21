import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/constants.dart';

class CustomTextInput extends HookWidget {
  const CustomTextInput({
    super.key,
    required this.onChanged,
    this.onClear,
    this.controller,
    this.hintText = 'Enter text...',
    this.fieldLabel = 'Enter label...',
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
    this.validator,
    this.isRequired = false,
    this.minLength,
    this.maxLength,
  });

  final void Function(String) onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final String hintText;
  final String fieldLabel;
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
  final String? Function(String?)? validator;
  final bool isRequired;
  final int? minLength;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final TextEditingController effectiveController = controller ??
        useTextEditingController(
          text: initialValue,
        );
    final ValueNotifier<bool> showClearButton = useState(false);
    final ValueNotifier<bool> showPassword = useState(false);

    useEffect(() {
      void updateClearButtonVisibility() {
        showClearButton.value = effectiveController.text.isNotEmpty;
      }

      effectiveController.addListener(updateClearButtonVisibility);
      return () =>
          effectiveController.removeListener(updateClearButtonVisibility);
    }, <Object?>[effectiveController]);

    Widget? buildSuffixIcon() {
      if (obscureText) {
        return IconButton(
          icon: Icon(
            showPassword.value ? Icons.visibility_off : Icons.visibility,
            color: hintColor ?? Colors.grey.shade600,
          ),
          onPressed: () => showPassword.value = !showPassword.value,
        );
      }

      if (showClearButton.value && onClear != null) {
        return IconButton(
          icon: Icon(Icons.clear, color: hintColor ?? Colors.grey.shade600),
          onPressed: () {
            effectiveController.clear();
            onClear!();
          },
        );
      }

      return suffixIcon;
    }

    return TextFormField(
      controller: effectiveController,
      onChanged: onChanged,
      validator: validator ??
          (String? value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            if (minLength != null && value!.length < minLength!) {
              return 'Must be at least $minLength characters';
            }
            if (maxLength != null && value!.length > maxLength!) {
              return 'Must be at most $maxLength characters';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: fieldLabel, // Added labelText for the field label
        labelStyle: TextStyle(
          color: hintColor ?? Colors.grey.shade600,
          fontSize: 16, // Adjust font size if needed
        ),
        
        prefixIcon: prefixIcon,
        suffixIcon: buildSuffixIcon(),
        filled: true,
        fillColor: fillColor ?? GlobalStyles.defaultFillColor,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorText != null
                ? Colors.red
                : borderColor ?? GlobalStyles.defaultBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: errorText != null
                ? Colors.red
                : focusedBorderColor ?? GlobalStyles.defaultFocusedBorderColor,
          ),
        ),
        errorText: errorText,
      ),
      style: TextStyle(color: textColor),
      cursorColor: cursorColor ?? GlobalStyles.defaultFocusedBorderColor,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText && !showPassword.value,
      maxLines: maxLines,
      enabled: enabled,
    );
  }
}
