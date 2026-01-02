import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDialogTheme {
  AppDialogTheme._();

  static DialogThemeData lightDialogTheme = DialogThemeData(
    backgroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),
    contentTextStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    iconColor: AppColors.primary,
  );

  static DialogThemeData darkDialogTheme = DialogThemeData(
    backgroundColor: AppColors.darkCard,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    contentTextStyle: const TextStyle(fontSize: 14, color: AppColors.white),
    iconColor: AppColors.primaryLight,
  );
}
