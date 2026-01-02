import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_extensions.dart';

Widget WelcomeText(BuildContext context) {
  return Column(
    children: [
      Text(
        'Welcome to ESTIMA! 👋',
        style: context.titleLargeStyle.copyWith(
          fontSize: context.fontSizeLg * 1.2,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: context.sm),
      Text(
        'Please sign-in to your account and start the adventure',
        style: context.bodyStyle.copyWith(),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
