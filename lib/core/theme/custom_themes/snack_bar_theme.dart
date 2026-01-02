import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppSnackBarTheme {
  AppSnackBarTheme._();

  static SnackBarThemeData lightSnackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.dark,
    actionTextColor: AppColors.primary,
    contentTextStyle: const TextStyle(fontSize: 14, color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 6,
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );

  static SnackBarThemeData darkSnackBarTheme = SnackBarThemeData(
    backgroundColor: Colors.white,
    actionTextColor: AppColors.primaryLight,
    contentTextStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 6,
    showCloseIcon: true,
    closeIconColor: AppColors.dark,
  );
}
