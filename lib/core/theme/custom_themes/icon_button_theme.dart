import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppIconButtonTheme {
  AppIconButtonTheme._();

  static IconButtonThemeData lightIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.primary,
      backgroundColor: Colors.transparent,
      hoverColor: AppColors.primary.withOpacity(0.1),
      focusColor: AppColors.primary.withOpacity(0.2),
      disabledForegroundColor: AppColors.grey,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static IconButtonThemeData darkIconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.primaryLight,
      backgroundColor: Colors.transparent,
      hoverColor: AppColors.primaryLight.withOpacity(0.1),
      focusColor: AppColors.primaryLight.withOpacity(0.2),
      disabledForegroundColor: AppColors.grey,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
