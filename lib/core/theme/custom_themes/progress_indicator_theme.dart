import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppProgressIndicatorTheme {
  AppProgressIndicatorTheme._();

  static ProgressIndicatorThemeData lightProgressIndicatorTheme =
      ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.lightGrey,
        circularTrackColor: AppColors.lightGrey,
        linearMinHeight: 4,
        refreshBackgroundColor: AppColors.light,
      );

  static ProgressIndicatorThemeData darkProgressIndicatorTheme =
      ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.darkGrey,
        circularTrackColor: AppColors.darkGrey,
        linearMinHeight: 4,
        refreshBackgroundColor: AppColors.darkBackground,
      );
}
