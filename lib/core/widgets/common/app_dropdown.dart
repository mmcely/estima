import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final String? value;
  final List<String> items;
  final Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final Color? iconColor;
  final bool showError;
  final EdgeInsets? padding;

  const AppDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.iconColor,
    this.showError = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: enabled
                  ? theme.textTheme.bodyMedium?.color?.withOpacity(0.8)
                  : theme.disabledColor,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: !enabled
                    ? theme.disabledColor
                    : (showError &&
                          validator != null &&
                          validator!(value) != null)
                    ? AppColors.error
                    : theme.dividerColor,
                width: 1,
              ),
              color: !enabled ? theme.cardColor : theme.cardColor,
            ),
            child: AbsorbPointer(
              absorbing: !enabled,
              child: DropdownButtonFormField<String>(
                value: value,
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: enabled
                        ? theme.iconTheme.color
                        : theme.disabledColor,
                  ),
                  hintText: enabled ? hint : value ?? hint,
                  hintStyle: TextStyle(
                    color: !enabled ? theme.disabledColor : theme.hintColor,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: enabled ? theme.iconTheme.color : theme.disabledColor,
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: enabled
                      ? theme.textTheme.bodyMedium?.color
                      : theme.disabledColor,
                ),
                dropdownColor: theme.cardColor,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    enabled: enabled,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: !enabled
                            ? theme.disabledColor
                            : item.startsWith('Select')
                            ? theme.hintColor
                            : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: enabled ? onChanged : null,
                validator: showError ? validator : null,
              ),
            ),
          ),
          if (showError &&
              validator != null &&
              validator!(value) != null &&
              enabled)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                validator!(value) ?? '',
                style: TextStyle(color: AppColors.error, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
