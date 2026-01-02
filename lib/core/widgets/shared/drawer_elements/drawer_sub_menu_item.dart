import 'package:flutter/material.dart';

Widget DrawerSubMenuItem(
  BuildContext context, {
  required String title,
  VoidCallback? onTap,
}) {
  return ListTile(
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
    ),
    onTap: onTap,
    dense: true,
    contentPadding: const EdgeInsets.only(left: 32, right: 16),
  );
}
