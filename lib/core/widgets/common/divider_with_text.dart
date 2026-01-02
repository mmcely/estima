import 'package:flutter/material.dart';

import '../../responsive/responsive_sizes.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const DividerWithText({super.key, required this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: theme.dividerColor,
            thickness: theme.dividerTheme.thickness ?? 1.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizes.md(context),
          ),
          child: Text(
            text,
            style:
                textStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  fontSize: ResponsiveSizes.fontSizeSm(context),
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: theme.dividerColor,
            thickness: theme.dividerTheme.thickness ?? 1.0,
          ),
        ),
      ],
    );
  }
}
