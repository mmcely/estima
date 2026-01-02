import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppFloatingActionButtonTheme {
  AppFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        hoverElevation: 8,
        focusElevation: 8,
        disabledElevation: 0,
        shape: CircleBorder(),
        sizeConstraints: BoxConstraints.tightFor(width: 56, height: 56),
      );

  static FloatingActionButtonThemeData darkFloatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        elevation: 6,
        hoverElevation: 10,
        focusElevation: 10,
        disabledElevation: 0,
        shape: CircleBorder(),
        sizeConstraints: BoxConstraints.tightFor(width: 56, height: 56),
      );
}
