import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppMenuButtonTheme {
  AppMenuButtonTheme._();

  static MenuButtonThemeData lightMenuButtonTheme = MenuButtonThemeData(
    style: MenuItemButton.styleFrom(
      foregroundColor: AppColors.dark,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static MenuButtonThemeData darkMenuButtonTheme = MenuButtonThemeData(
    style: MenuItemButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
