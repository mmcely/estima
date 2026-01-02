import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppChipTheme {
  AppChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    backgroundColor: AppColors.lightGrey,
    deleteIconColor: AppColors.dark,
    disabledColor: AppColors.grey.withOpacity(0.2),
    selectedColor: AppColors.primary,
    secondarySelectedColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    side: BorderSide.none,
    labelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    secondaryLabelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    brightness: Brightness.light,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    backgroundColor: AppColors.darkGrey.withOpacity(0.3),
    deleteIconColor: AppColors.white,
    disabledColor: AppColors.grey.withOpacity(0.1),
    selectedColor: AppColors.primaryLight,
    secondarySelectedColor: AppColors.primaryLight,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    side: BorderSide.none,
    labelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    secondaryLabelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    brightness: Brightness.dark,
  );
}
