import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'custom_themes/action_icon_theme.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/badge_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/button_bar_theme.dart';
import 'custom_themes/button_theme.dart';
import 'custom_themes/card_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/data_picker_theme.dart';
import 'custom_themes/data_table_theme.dart';
import 'custom_themes/dialog_theme.dart';
import 'custom_themes/divider_theme.dart';
import 'custom_themes/drawer_theme.dart';
import 'custom_themes/dropdownmenu_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/filled_button_theme.dart';
import 'custom_themes/floating_action_button_theme.dart';
import 'custom_themes/icon_button_theme.dart';
import 'custom_themes/icon_theme.dart';
import 'custom_themes/list_tile_theme.dart';
import 'custom_themes/menu_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/popup_menu_theme.dart';
import 'custom_themes/progress_indicator_theme.dart';
import 'custom_themes/snack_bar_theme.dart';
import 'custom_themes/text_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/tooltip_theme.dart';

class AppThemes {
  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.light,

      // Text themes
      textTheme: AppTextTheme.lightTextTheme,

      // App bar themes
      appBarTheme: MAppBarTheme.lightAppBarTheme,

      // Form themes
      checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
      datePickerTheme: AppDataPickerTheme.lightDatePickerTheme,
      dropdownMenuTheme: AppDropdownMenuTheme.lightDropdownMenuTheme,

      // Button themes
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
      textButtonTheme: AppTextButtonTheme.lightTextButtonTheme,
      filledButtonTheme: AppFilledButtonTheme.lightFilledButtonTheme,
      iconButtonTheme: AppIconButtonTheme.lightIconButtonTheme,
      floatingActionButtonTheme:
          AppFloatingActionButtonTheme.lightFloatingActionButtonTheme,

      // Navigation themes
      drawerTheme: AppDrawerTheme.lightDrawerTheme,
      actionIconTheme: AppActionIconTheme.lightActionIconTheme,
      bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
      popupMenuTheme: AppPopupMenuTheme.lightPopupMenuTheme,

      // UI component themes
      cardTheme: AppCardTheme.lightCardTheme,
      chipTheme: AppChipTheme.lightChipTheme,
      dividerTheme: AppDividerTheme.lightDividerTheme,
      dataTableTheme: AppDataTableTheme.lightDataTableTheme,
      dialogTheme: AppDialogTheme.lightDialogTheme,
      badgeTheme: AppBadgeTheme.lightBadgeTheme,

      buttonTheme: AppButtonTheme.lightButtonTheme,
      buttonBarTheme: AppButtonBarTheme.lightButtonBarTheme,
      menuButtonTheme: AppMenuButtonTheme.lightMenuButtonTheme,
      snackBarTheme: AppSnackBarTheme.lightSnackBarTheme,
      tooltipTheme: AppTooltipTheme.lightTooltipTheme,
      listTileTheme: AppListTileTheme.lightListTileTheme,
      progressIndicatorTheme:
          AppProgressIndicatorTheme.lightProgressIndicatorTheme,
      iconTheme: AppIconTheme.lightIconTheme,

      // Specific Material 3 themes
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.primary.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.primary.withOpacity(0.1),
        labelType: NavigationRailLabelType.all,
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(AppColors.lightGrey),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      searchViewTheme: SearchViewThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.darkSurface,

      // Text themes
      textTheme: AppTextTheme.darkTextTheme,

      // App bar themes
      appBarTheme: MAppBarTheme.darkAppBarTheme,

      // Form themes
      checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
      datePickerTheme: AppDataPickerTheme.darkDatePickerTheme,
      dropdownMenuTheme: AppDropdownMenuTheme.darkDropdownMenuTheme,

      // Button themes
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
      textButtonTheme: AppTextButtonTheme.darkTextButtonTheme,
      filledButtonTheme: AppFilledButtonTheme.darkFilledButtonTheme,
      iconButtonTheme: AppIconButtonTheme.darkIconButtonTheme,
      floatingActionButtonTheme:
          AppFloatingActionButtonTheme.darkFloatingActionButtonTheme,

      // Navigation themes
      drawerTheme: AppDrawerTheme.darkDrawerTheme,
      actionIconTheme: AppActionIconTheme.darkActionIconTheme,
      bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
      popupMenuTheme: AppPopupMenuTheme.darkPopupMenuTheme,

      // UI component themes
      cardTheme: AppCardTheme.darkCardTheme,
      chipTheme: AppChipTheme.darkChipTheme,
      dividerTheme: AppDividerTheme.darkDividerTheme,
      dataTableTheme: AppDataTableTheme.darkDataTableTheme,
      dialogTheme: AppDialogTheme.darkDialogTheme,
      badgeTheme: AppBadgeTheme.darkBadgeTheme,

      // Missing themes - To be added
      buttonTheme: AppButtonTheme.darkButtonTheme,
      buttonBarTheme: AppButtonBarTheme.darkButtonBarTheme,
      menuButtonTheme: AppMenuButtonTheme.darkMenuButtonTheme,
      snackBarTheme: AppSnackBarTheme.darkSnackBarTheme,
      tooltipTheme: AppTooltipTheme.darkTooltipTheme,
      listTileTheme: AppListTileTheme.darkListTileTheme,
      progressIndicatorTheme:
          AppProgressIndicatorTheme.darkProgressIndicatorTheme,
      iconTheme: AppIconTheme.darkIconTheme,

      // Specific Material 3 themes
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkCard,
        indicatorColor: AppColors.primaryLight.withOpacity(0.1),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.darkCard,
        indicatorColor: AppColors.primaryLight.withOpacity(0.1),
        labelType: NavigationRailLabelType.all,
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(AppColors.darkGrey),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      searchViewTheme: SearchViewThemeData(
        backgroundColor: AppColors.darkCard,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
