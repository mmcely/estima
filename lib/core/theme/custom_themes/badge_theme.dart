import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppBadgeTheme {
  AppBadgeTheme._();

  static BadgeThemeData lightBadgeTheme = BadgeThemeData(
    textColor: AppColors.white,
    backgroundColor: AppColors.error,
    largeSize: 20,
    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
  );

  static BadgeThemeData darkBadgeTheme = BadgeThemeData(
    textColor: AppColors.white,
    backgroundColor: AppColors.error,
    largeSize: 20,
    textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
  );
}
