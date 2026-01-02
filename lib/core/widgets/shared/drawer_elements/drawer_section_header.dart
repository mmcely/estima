import 'package:flutter/material.dart';

import '../../../../../core/responsive/responsive_extensions.dart';

Widget DrawerSectionHeader(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      context.md,
      context.lg,
      context.md,
      context.sm,
    ),
    child: Text(
      title,
      style: context.bodySmallStyle.copyWith(
        color: Theme.of(context).disabledColor,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
