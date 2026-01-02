import 'package:flutter/material.dart';

Widget ExpandableDrawerItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  required List<Widget> children,
}) {
  return ExpansionTile(
    leading: Icon(icon, color: Theme.of(context).iconTheme.color),
    title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
    children: children,
    initiallyExpanded: false,
    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
    childrenPadding: const EdgeInsets.only(left: 16),
  );
}
