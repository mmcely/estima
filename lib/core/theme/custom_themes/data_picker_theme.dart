import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDataPickerTheme {
  AppDataPickerTheme._();

  static DatePickerThemeData lightDatePickerTheme = DatePickerThemeData(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.primary,
    dayStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    weekdayStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    yearStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    headerHelpStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.dark,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static DatePickerThemeData darkDatePickerTheme = DatePickerThemeData(
    backgroundColor: AppColors.darkCard,
    surfaceTintColor: AppColors.primaryLight,
    dayStyle: const TextStyle(fontSize: 14, color: AppColors.white),
    weekdayStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    yearStyle: const TextStyle(fontSize: 14, color: AppColors.white),
    headerHelpStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.white,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
