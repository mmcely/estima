import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppFilledButtonTheme {
  AppFilledButtonTheme._();

  static FilledButtonThemeData lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      disabledBackgroundColor: AppColors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  static FilledButtonThemeData darkFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primaryLight,
      disabledBackgroundColor: AppColors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}
