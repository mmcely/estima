import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDropdownMenuTheme {
  AppDropdownMenuTheme._();

  static DropdownMenuThemeData lightDropdownMenuTheme = DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.white),
      surfaceTintColor: WidgetStateProperty.all(AppColors.primary),
      elevation: WidgetStateProperty.all(4),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textStyle: const TextStyle(fontSize: 14, color: AppColors.dark),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.light,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.lightGrey),
      ),
    ),
  );

  static DropdownMenuThemeData darkDropdownMenuTheme = DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.darkCard),
      surfaceTintColor: WidgetStateProperty.all(AppColors.primaryLight),
      elevation: WidgetStateProperty.all(6),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textStyle: const TextStyle(fontSize: 14, color: AppColors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.darkGrey),
      ),
    ),
  );
}
