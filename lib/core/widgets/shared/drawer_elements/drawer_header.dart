import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';

Widget CustomDrawerHeader(BuildContext context, Map<String, dynamic> userData) {
  return DrawerHeader(
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: context.isMobile ? 24 : 28,
          backgroundImage: NetworkImage(
            userData['avatar'] ?? 'https://via.placeholder.com/150',
          ),
        ),
        SizedBox(height: context.sm),
        Text(
          userData['name'] ?? 'User',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2),
        Text(
          '${userData['role']} • ${userData['company']}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(),
        ),
      ],
    ),
  );
}
