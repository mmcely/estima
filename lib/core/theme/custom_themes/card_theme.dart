import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppCardTheme {
  AppCardTheme._();

  static CardThemeData lightCardTheme = CardThemeData(
    color: AppColors.white,
    shadowColor: AppColors.dark.withOpacity(0.1),
    surfaceTintColor: Colors.transparent,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.lightGrey.withOpacity(0.5), width: 1),
    ),
  );

  static CardThemeData darkCardTheme = CardThemeData(
    color: AppColors.darkCard,
    shadowColor: AppColors.black.withOpacity(0.3),
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.darkGrey.withOpacity(0.5), width: 1),
    ),
  );
}
