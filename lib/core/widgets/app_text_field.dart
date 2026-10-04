import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? hintText;
  final String? errorText;
  final String? initialValue;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  // Constraints
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  // Colors
  final Color? colorPrefixIcon;
  final Color? colorSuffixIcon;
  final Color? fillColor;
  final Color? borderColor;

  final VoidCallback? onSuffixIconPressed;

  final bool obscureText;
  final bool readOnly;
  final bool enabled;

  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  final TextAlign textAlign;

  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  // Style Field
  final TextStyle? style;
  final TextStyle? hintStyle;

  // Border Field
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final OutlineInputBorder? disabledBorder;

  const AppTextField({
    super.key,
    this.controller,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.colorPrefixIcon,
    this.colorSuffixIcon,
    this.prefixWidget,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderColor = borderColor ?? theme.colorScheme.outline;
    final defaultFillColor = fillColor ?? theme.colorScheme.surface;
    final defaultRadius = borderRadius ?? 12.0;

    const defaultConstraints = BoxConstraints(minWidth: 48, minHeight: 48);

    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      textAlign: textAlign,
      style: style ?? theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        prefixIconConstraints: prefixIconConstraints ?? defaultConstraints,
        suffixIconConstraints: suffixIconConstraints ?? defaultConstraints,
        hintText: hintText,
        errorText: errorText,
        hintStyle:
            hintStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),

        prefixIcon: prefixIcon != null && prefixWidget == null
            ? Icon(
                prefixIcon,
                color: colorPrefixIcon ?? theme.colorScheme.onSurfaceVariant,
              )
            : prefixWidget,

        suffixIcon: suffixIcon != null && suffixWidget == null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: colorSuffixIcon ?? theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: onSuffixIconPressed,
              )
            : suffixWidget,

        filled: true,
        fillColor: defaultFillColor,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(color: defaultBorderColor),
            ),

        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),

        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.5,
              ),
            ),

        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),

        disabledBorder:
            disabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultRadius),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withAlpha(3),
              ),
            ),
      ),
    );
  }
}
