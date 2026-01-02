import 'package:flutter/material.dart';
import '../utils/sizes.dart';
import 'responsive.dart';

class ResponsiveSizes {
  ResponsiveSizes._();

  // ========== BASE METHOD ==========
  static double adaptiveSize({
    required BuildContext context,
    required double mobile,
    required double tablet,
    required double desktop,
    double? largeDesktop,
  }) {
    if (Responsive.isLargeDesktop(context)) {
      return largeDesktop ?? desktop * 1.2;
    } else if (Responsive.isDesktop(context)) {
      return desktop;
    } else if (Responsive.isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }

  // ========== BREAKPOINTS ==========
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  // ========== PADDING AND MARGIN SIZES ==========
  static double xs(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.xs,
    tablet: 6.0,
    desktop: 8.0,
  );

  static double sm(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.sm,
    tablet: 12.0,
    desktop: 14.0,
  );

  static double md(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.md,
    tablet: 18.0,
    desktop: 20.0,
  );

  static double lg(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.lg,
    tablet: 24.0,
    desktop: 28.0,
  );

  static double xl(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.xl,
    tablet: 36.0,
    desktop: 42.0,
  );

  // ========== ICON SIZES ==========
  static double iconXs(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.iconXs,
    tablet: 14.0,
    desktop: 16.0,
  );

  static double iconSm(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.iconSm,
    tablet: 18.0,
    desktop: 20.0,
  );

  static double iconMd(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.iconMd,
    tablet: 26.0,
    desktop: 28.0,
  );

  static double iconLg(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.iconLg,
    tablet: 36.0,
    desktop: 40.0,
  );

  // ========== FONT SIZES ==========
  static double fontSizeSm(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.fontSizeSm,
    tablet: 15.0,
    desktop: 16.0,
  );

  static double fontSizeMd(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.fontSizeMd,
    tablet: 17.0,
    desktop: 18.0,
  );

  static double fontSizeLg(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.fontSizeLg,
    tablet: 20.0,
    desktop: 22.0,
  );

  // ========== BUTTON SIZES ==========
  static double buttonHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: 48.0, // Fix: TSizes.buttonHeight = 16.0 is too small
    tablet: 52.0,
    desktop: 56.0,
  );

  static double buttonRadius(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.buttonRadius,
    tablet: 24.0,
    desktop: 26.0,
  );

  static double buttonWidth(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.buttonWidth,
    tablet: 140.0,
    desktop: 160.0,
  );

  static double buttonElevation(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.buttonElevation,
    tablet: 5.0,
    desktop: 6.0,
  );

  // ========== APP BAR ==========
  static double appBarHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.appBarHeight,
    tablet: 64.0,
    desktop: 72.0,
  );

  // ========== IMAGE SIZES ==========
  static double imageThumbSize(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.imageThumbSize,
    tablet: 100.0,
    desktop: 120.0,
  );

  static double productImageSize(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.productImageSize,
    tablet: 140.0,
    desktop: 160.0,
  );

  static double productImageRadius(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.productImageRadius,
    tablet: 18.0,
    desktop: 20.0,
  );

  // ========== SPACING ==========
  static double defaultSpace(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.defaultSpace,
    tablet: 24.0,
    desktop: 28.0,
  );

  static double spaceBtwItems(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.spaceBtwItems,
    tablet: 16.0,
    desktop: 20.0,
  );

  static double spaceBtwSections(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.spaceBtwSections,
    tablet: 40.0,
    desktop: 48.0,
  );

  // ========== BORDER RADIUS ==========
  static double borderRadiusSm(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.borderRadiusSm,
    tablet: 6.0,
    desktop: 8.0,
  );

  static double borderRadiusMd(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.borderRadiusMd,
    tablet: 10.0,
    desktop: 12.0,
  );

  static double borderRadiusLg(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.borderRadiusLg,
    tablet: 18.0,
    desktop: 20.0,
  );

  // ========== DIVIDER ==========
  static double dividerHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.dividerHeight,
    tablet: 1.5,
    desktop: 2.0,
  );

  // ========== PRODUCT ITEMS ==========
  static double productItemHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.productItemHeight,
    tablet: 180.0,
    desktop: 200.0,
  );

  // ========== INPUT FIELD ==========
  static double inputFieldRadius(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.inputFieldRadius,
    tablet: 18.0,
    desktop: 20.0,
  );

  static double spaceBtwInputFields(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.spaceBtwInputFields,
    tablet: 20.0,
    desktop: 24.0,
  );

  // ========== CARD SIZES ==========
  static double cardRadiusLg(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardRadiusLg,
    tablet: 20.0,
    desktop: 24.0,
  );

  static double cardRadiusM(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardRadiusM,
    tablet: 18.0,
    desktop: 20.0,
  );

  static double cardRadiusMd(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardRadiusMd,
    tablet: 16.0,
    desktop: 18.0,
  );

  static double cardRadiusSm(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardRadiusSm,
    tablet: 14.0,
    desktop: 16.0,
  );

  static double cardRadiusXs(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardRadiusXs,
    tablet: 10.0,
    desktop: 12.0,
  );

  static double cardElevation(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.cardElevation,
    tablet: 3.0,
    desktop: 4.0,
  );

  // ========== IMAGE CAROUSEL ==========
  static double imageCarouselHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.imageCarouselHeight,
    tablet: 240.0,
    desktop: 280.0,
  );

  // ========== LOADING INDICATOR ==========
  static double loadingIndicatorSize(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.loadingIndicatorSize,
    tablet: 40.0,
    desktop: 44.0,
  );

  // ========== GRID VIEW ==========
  static double gridViewSpacing(BuildContext context) => adaptiveSize(
    context: context,
    mobile: TSizes.gridViewSpacing,
    tablet: 20.0,
    desktop: 24.0,
  );

  // ========== SPECIFIC ESTIMA DIMENSIONS ==========
  static double projectCardHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: 120.0,
    tablet: 140.0,
    desktop: 160.0,
  );

  static double taskCardHeight(BuildContext context) => adaptiveSize(
    context: context,
    mobile: 80.0,
    tablet: 90.0,
    desktop: 100.0,
  );

  static double sidebarWidth(BuildContext context) =>
      adaptiveSize(context: context, mobile: 0.0, tablet: 80.0, desktop: 280.0);

  static int projectsPerRow(BuildContext context) {
    if (Responsive.isMobile(context)) return 1;
    if (Responsive.isTablet(context)) return 2;
    return 3;
  }

  static int tasksPerRow(BuildContext context) {
    if (Responsive.isMobile(context)) return 1;
    if (Responsive.isTablet(context)) return 2;
    return 4;
  }

  // ========== PADDING HELPERS ==========
  static EdgeInsetsGeometry paddingAll(BuildContext context, {double? value}) {
    final paddingValue = value ?? sm(context);
    return EdgeInsets.all(paddingValue);
  }

  static EdgeInsetsGeometry paddingHorizontal(
    BuildContext context, {
    double? value,
  }) {
    final paddingValue = value ?? md(context);
    return EdgeInsets.symmetric(horizontal: paddingValue);
  }

  static EdgeInsetsGeometry paddingVertical(
    BuildContext context, {
    double? value,
  }) {
    final paddingValue = value ?? sm(context);
    return EdgeInsets.symmetric(vertical: paddingValue);
  }

  static EdgeInsetsGeometry paddingSymmetric(
    BuildContext context, {
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? md(context),
      vertical: vertical ?? sm(context),
    );
  }

  // ========== PREDEFINED TEXT STYLES ==========
  static TextStyle titleLargeStyle(BuildContext context) =>
      TextStyle(fontSize: fontSizeLg(context), fontWeight: FontWeight.w600);

  static TextStyle titleMediumStyle(BuildContext context) =>
      TextStyle(fontSize: fontSizeMd(context), fontWeight: FontWeight.w500);

  static TextStyle bodyStyle(BuildContext context) =>
      TextStyle(fontSize: fontSizeSm(context), fontWeight: FontWeight.normal);

  static TextStyle captionStyle(BuildContext context) => TextStyle(
    fontSize: fontSizeSm(context) - 2,
    fontWeight: FontWeight.normal,
  );

  // ========== SHAPE HELPERS ==========
  static BorderRadius borderRadiusSmAll(BuildContext context) =>
      BorderRadius.all(Radius.circular(borderRadiusSm(context)));

  static BorderRadius borderRadiusMdAll(BuildContext context) =>
      BorderRadius.all(Radius.circular(borderRadiusMd(context)));

  static BorderRadius borderRadiusLgAll(BuildContext context) =>
      BorderRadius.all(Radius.circular(borderRadiusLg(context)));

  static RoundedRectangleBorder roundedRectangleSm(BuildContext context) =>
      RoundedRectangleBorder(borderRadius: borderRadiusSmAll(context));

  static RoundedRectangleBorder roundedRectangleMd(BuildContext context) =>
      RoundedRectangleBorder(borderRadius: borderRadiusMdAll(context));

  static RoundedRectangleBorder roundedRectangleLg(BuildContext context) =>
      RoundedRectangleBorder(borderRadius: borderRadiusLgAll(context));

  // ========== ANIMATION DURATIONS ==========
  static Duration get animationShort => const Duration(milliseconds: 200);
  static Duration get animationMedium => const Duration(milliseconds: 300);
  static Duration get animationLong => const Duration(milliseconds: 500);

  // ========== SIMPLE GETTERS ==========
  static bool get isDarkMode => false; // To complete with your logic

  // ========== UTILITY METHOD FOR MAX WIDTH ==========
  static double maxContainerWidth(BuildContext context) {
    if (Responsive.isMobile(context)) return 600;
    if (Responsive.isTablet(context)) return 900;
    if (Responsive.isDesktop(context)) return 1200;
    return 1400;
  }
}
