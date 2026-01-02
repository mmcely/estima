import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDividerTheme {
  AppDividerTheme._();

  static DividerThemeData lightDividerTheme = DividerThemeData(
    color: AppColors.lightGrey,
    thickness: 1,
    space: 16,
    indent: 16,
    endIndent: 16,
  );

  static DividerThemeData darkDividerTheme = DividerThemeData(
    color: AppColors.darkGrey,
    thickness: 1,
    space: 16,
    indent: 16,
    endIndent: 16,
  );
}
