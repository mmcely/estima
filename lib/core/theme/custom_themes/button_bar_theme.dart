import 'package:flutter/material.dart';

class AppButtonBarTheme {
  AppButtonBarTheme._();

  static ButtonBarThemeData lightButtonBarTheme = ButtonBarThemeData(
    alignment: MainAxisAlignment.end,
    buttonHeight: 40,
    buttonMinWidth: 88,
    buttonPadding: EdgeInsets.symmetric(horizontal: 16),
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
  );

  static ButtonBarThemeData darkButtonBarTheme = ButtonBarThemeData(
    alignment: MainAxisAlignment.end,
    buttonHeight: 40,
    buttonMinWidth: 88,
    buttonPadding: EdgeInsets.symmetric(horizontal: 16),
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
  );
}
