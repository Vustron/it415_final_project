import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/src/components.dart';
import 'package:babysitterapp/src/constants.dart';

class CustomSelect<T extends Object> extends HookWidget {
  const CustomSelect({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint = 'Select an option',
    this.label,
    this.displayStringFor,
    this.isSearchable = false,
    this.decoration,
    this.menuMaxHeight,
    this.prefix,
    this.suffix,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15.0),
    this.style,
    this.hintStyle,
    this.labelStyle,
    this.isDense = false,
    this.borderRadius = 20.0,
    this.fillColor,
    this.enabled = true,
    this.onTap,
    this.autoFocus = false,
    this.errorText,
    this.validator,
    this.isRequired = false,
  });

  final T? value;
  final List<T> items;
  final void Function(T?) onChanged;
  final String hint;
  final String? label;
  final String Function(T)? displayStringFor;
  final bool isSearchable;
  final InputDecoration? decoration;
  final double? menuMaxHeight;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool isDense;
  final double borderRadius;
  final Color? fillColor;
  final bool? enabled;
  final VoidCallback? onTap;
  final bool autoFocus;
  final String? errorText;
  final String? Function(T?)? validator;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (isSearchable)
          _buildSearchableDropdown(context)
        else
          _buildRegularDropdown(context),
      ],
    );
  }

  Widget _buildRegularDropdown(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      hint: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(
          hint,
          style: hintStyle ?? TextStyle(color: Colors.grey.shade600),
        ),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            displayStringFor?.call(item) ?? item.toString(),
            style: style,
          ),
        );
      }).toList(),
      onChanged: enabled! ? onChanged : null,
      validator: validator ??
          (T? value) {
            if (isRequired && value == null) {
              return 'This field is required';
            }
            return null;
          },
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            prefixIcon: prefix,
            suffixIcon: suffix,
            contentPadding: contentPadding,
            filled: fillColor != null,
            fillColor: fillColor,
            isDense: isDense,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : GlobalStyles.defaultBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : GlobalStyles.defaultBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorText != null
                    ? Colors.red
                    : GlobalStyles.defaultFocusedBorderColor,
              ),
            ),
            labelStyle: labelStyle,
          ),
      menuMaxHeight: menuMaxHeight,
      isDense: isDense,
      autofocus: autoFocus,
      isExpanded: true,
    );
  }

  Widget _buildSearchableDropdown(BuildContext context) {
    return Autocomplete<T>(
      initialValue: value != null
          ? TextEditingValue(
              text: displayStringFor?.call(value!) ?? value.toString())
          : null,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return items;
        }
        return items.where((T item) {
          final String itemStr =
              displayStringFor?.call(item) ?? item.toString();
          return itemStr
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption:
          displayStringFor ?? (T option) => option.toString(),
      onSelected: onChanged,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return CustomTextInput(
          controller: textEditingController,
          hintText: hint,
          prefixIcon: prefix,
          suffixIcon: suffix,
          fillColor: fillColor,
          textColor: style?.color,
          hintColor: hintStyle?.color,
          borderColor:
              errorText != null ? Colors.red : GlobalStyles.defaultBorderColor,
          focusedBorderColor: errorText != null
              ? Colors.red
              : GlobalStyles.defaultFocusedBorderColor,
          borderRadius: borderRadius,
          contentPadding: contentPadding,
          onChanged: (String value) {},
          enabled: enabled!,
          validator: (String? value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return validator?.call(value as T?);
          },
        );
      },
    );
  }
}
