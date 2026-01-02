import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppIconTheme {
  AppIconTheme._();

  static IconThemeData lightIconTheme = IconThemeData(color: AppColors.dark);

  static IconThemeData darkIconTheme = IconThemeData(color: AppColors.light);
}
