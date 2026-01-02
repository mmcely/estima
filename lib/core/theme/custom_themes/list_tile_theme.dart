import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppListTileTheme {
  AppListTileTheme._();

  static ListTileThemeData lightListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    minVerticalPadding: 8,
    minLeadingWidth: 40,
    iconColor: AppColors.dark,
    textColor: AppColors.dark,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    subtitleTextStyle: TextStyle(fontSize: 14, color: AppColors.darkGrey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    tileColor: Colors.transparent,
    selectedTileColor: AppColors.primary.withOpacity(0.1),
    selectedColor: AppColors.primary,
  );

  static ListTileThemeData darkListTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    minVerticalPadding: 8,
    minLeadingWidth: 40,
    iconColor: Colors.white,
    textColor: Colors.white,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    subtitleTextStyle: TextStyle(fontSize: 14, color: AppColors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    tileColor: Colors.transparent,
    selectedTileColor: AppColors.primaryLight.withOpacity(0.1),
    selectedColor: AppColors.primaryLight,
  );
}
