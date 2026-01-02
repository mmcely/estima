import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/images.dart';

Widget LogoSection(BuildContext context) {
  return Column(
    children: [
      // Logo
      Container(
        width: context.iconLg * 2,
        height: context.iconLg * 2,
        decoration: BoxDecoration(
          borderRadius: context.borderRadiusLgAll,
          color: AppColors.primary.withOpacity(0.1),
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            width: context.iconLg * 1.8,
            height: context.iconLg * 1.8,
          ),
        ),
      ),
      SizedBox(height: context.sm),
      // App Name
      Text(
        'ESTIMA',
        style: context.titleLargeStyle.copyWith(
          fontSize: context.fontSizeLg * 1.5,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    ],
  );
}
