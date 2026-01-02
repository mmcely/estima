import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDataTableTheme {
  AppDataTableTheme._();

  static DataTableThemeData lightDataTableTheme = DataTableThemeData(
    headingRowColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => AppColors.lightGrey.withOpacity(0.3),
    ),
    dataRowColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary.withOpacity(0.1)
          : null,
    ),
    dividerThickness: 1,
    horizontalMargin: 16,
    columnSpacing: 24,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    dataTextStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    headingTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),
  );

  static DataTableThemeData darkDataTableTheme = DataTableThemeData(
    headingRowColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => AppColors.darkGrey.withOpacity(0.3),
    ),
    dataRowColor: WidgetStateProperty.resolveWith<Color?>(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primaryLight.withOpacity(0.1)
          : null,
    ),
    dividerThickness: 1,
    horizontalMargin: 16,
    columnSpacing: 24,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    dataTextStyle: const TextStyle(fontSize: 14, color: AppColors.white),
    headingTextStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );
}
