import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppActionIconTheme {
  AppActionIconTheme._();

  static ActionIconThemeData lightActionIconTheme = ActionIconThemeData(
    backButtonIconBuilder: LightBackButtonIconBuilder,
  );

  static ActionIconThemeData darkActionIconTheme = ActionIconThemeData(
    backButtonIconBuilder: DarkBackButtonIconBuilder,
  );

  static Widget LightBackButtonIconBuilder(BuildContext context) =>
      Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.dark, size: 24);

  static Widget DarkBackButtonIconBuilder(BuildContext context) =>
      Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white, size: 24);
}
