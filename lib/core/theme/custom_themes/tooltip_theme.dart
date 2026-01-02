import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppTooltipTheme {
  AppTooltipTheme._();

  static TooltipThemeData lightTooltipTheme = TooltipThemeData(
    constraints: BoxConstraints(minHeight: 32),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    margin: EdgeInsets.symmetric(horizontal: 16),
    textStyle: TextStyle(fontSize: 12, color: Colors.white),
    decoration: BoxDecoration(
      color: AppColors.dark,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  );

  static TooltipThemeData darkTooltipTheme = TooltipThemeData(
    constraints: BoxConstraints(minHeight: 32),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    margin: EdgeInsets.symmetric(horizontal: 16),
    textStyle: TextStyle(fontSize: 12, color: AppColors.dark),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  );
}
