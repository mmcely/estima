import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppDrawerTheme {
  AppDrawerTheme._();

  static DrawerThemeData lightDrawerTheme = DrawerThemeData(
    backgroundColor: AppColors.white,
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    width: 280,
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
  );

  static DrawerThemeData darkDrawerTheme = DrawerThemeData(
    backgroundColor: AppColors.darkCard,
    elevation: 16,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    width: 280,
    endShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
  );
}
