import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';

Widget DrawerItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
      size: context.iconSm,
    ),
    title: Text(title, style: context.bodyStyle),
    onTap: onTap,
    minLeadingWidth: context.iconMd,
    contentPadding: EdgeInsets.symmetric(horizontal: context.md),
  );
}
