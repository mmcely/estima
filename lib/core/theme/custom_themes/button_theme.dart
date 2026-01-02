import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class AppButtonTheme {
  AppButtonTheme._();

  // ButtonTheme (Material 2)
  static ButtonThemeData lightButtonTheme = ButtonThemeData(
    height: 48,
    minWidth: 88,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    buttonColor: AppColors.primary,
    disabledColor: AppColors.grey,
    focusColor: AppColors.primary.withOpacity(0.2),
    hoverColor: AppColors.primary.withOpacity(0.1),
  );

  static ButtonThemeData darkButtonTheme = ButtonThemeData(
    height: 48,
    minWidth: 88,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    buttonColor: AppColors.primaryLight,
    disabledColor: AppColors.grey,
    focusColor: AppColors.primaryLight.withOpacity(0.2),
    hoverColor: AppColors.primaryLight.withOpacity(0.1),
  );

  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  static ButtonStyle outlineButtonStyle(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
