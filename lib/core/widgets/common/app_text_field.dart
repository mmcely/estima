import 'package:flutter/material.dart';
import '../../responsive/responsive_extensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? label;
  final String? hint;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final String? suffixText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool? showPasswordToggle;
  final VoidCallback? onTogglePassword;
  final bool? isPasswordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? initialValue;
  final int? maxLines;
  final bool enabled;
  final int? maxLength;

  const AppTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.label,
    this.hint,
    this.icon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.suffixText,
    this.validator,
    this.keyboardType,
    this.showPasswordToggle = false,
    this.onTogglePassword,
    this.isPasswordVisible = false,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.maxLines = 1,
    this.enabled = true,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: showPasswordToggle == true
          ? !isPasswordVisible!
          : obscureText,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      enabled: enabled,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: _buildSuffixIcon(context),
        suffixText: suffixText,
        border: OutlineInputBorder(borderRadius: context.borderRadiusMdAll),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.md,
          vertical: context.sm,
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    if (showPasswordToggle == true && onTogglePassword != null) {
      return IconButton(
        icon: Icon(
          isPasswordVisible == true ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: onTogglePassword,
      );
    }

    if (suffixIcon != null) {
      return IconButton(icon: Icon(suffixIcon), onPressed: onSuffixIconTap);
    }

    return null;
  }
}
