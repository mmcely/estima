import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppPopupMenuTheme {
  AppPopupMenuTheme._();

  static PopupMenuThemeData lightPopupMenuTheme = PopupMenuThemeData(
    color: AppColors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 14, color: AppColors.dark),
    ),
  );

  static PopupMenuThemeData darkPopupMenuTheme = PopupMenuThemeData(
    color: AppColors.darkCard,
    surfaceTintColor: Colors.transparent,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 14, color: Colors.white),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 14, color: Colors.white),
    ),
  );
}
