import 'package:flutter/material.dart';
import 'responsive_sizes.dart';

extension ResponsiveExtensions on BuildContext {
  // ========== BREAKPOINTS ==========
  bool get isMobile => ResponsiveSizes.isMobile(this);
  bool get isTablet => ResponsiveSizes.isTablet(this);
  bool get isDesktop => ResponsiveSizes.isDesktop(this);

  // ========== TAILES ADAPTATIVES ==========
  double get xs => ResponsiveSizes.xs(this);
  double get sm => ResponsiveSizes.sm(this);
  double get md => ResponsiveSizes.md(this);
  double get lg => ResponsiveSizes.lg(this);
  double get xl => ResponsiveSizes.xl(this);

  double get iconXs => ResponsiveSizes.iconXs(this);
  double get iconSm => ResponsiveSizes.iconSm(this);
  double get iconMd => ResponsiveSizes.iconMd(this);
  double get iconLg => ResponsiveSizes.iconLg(this);

  double get fontSizeSm => ResponsiveSizes.fontSizeSm(this);
  double get fontSizeMd => ResponsiveSizes.fontSizeMd(this);
  double get fontSizeLg => ResponsiveSizes.fontSizeLg(this);

  double get buttonHeight => ResponsiveSizes.buttonHeight(this);
  double get buttonRadius => ResponsiveSizes.buttonRadius(this);
  double get buttonWidth => ResponsiveSizes.buttonWidth(this);
  double get buttonElevation => ResponsiveSizes.buttonElevation(this);

  double get appBarHeight => ResponsiveSizes.appBarHeight(this);
  double get imageThumbSize => ResponsiveSizes.imageThumbSize(this);

  double get defaultSpace => ResponsiveSizes.defaultSpace(this);
  double get spaceBtwItems => ResponsiveSizes.spaceBtwItems(this);
  double get spaceBtwSections => ResponsiveSizes.spaceBtwSections(this);

  double get borderRadiusSm => ResponsiveSizes.borderRadiusSm(this);
  double get borderRadiusMd => ResponsiveSizes.borderRadiusMd(this);
  double get borderRadiusLg => ResponsiveSizes.borderRadiusLg(this);

  double get inputFieldRadius => ResponsiveSizes.inputFieldRadius(this);
  double get spaceBtwInputFields => ResponsiveSizes.spaceBtwInputFields(this);

  double get cardRadiusLg => ResponsiveSizes.cardRadiusLg(this);
  double get cardRadiusMd => ResponsiveSizes.cardRadiusMd(this);
  double get cardElevation => ResponsiveSizes.cardElevation(this);

  double get loadingIndicatorSize => ResponsiveSizes.loadingIndicatorSize(this);
  double get gridViewSpacing => ResponsiveSizes.gridViewSpacing(this);

  // ========== DIMENSIONS SPÉCIFIQUES ESTIMA ==========
  double get projectCardHeight => ResponsiveSizes.projectCardHeight(this);
  double get taskCardHeight => ResponsiveSizes.taskCardHeight(this);
  double get sidebarWidth => ResponsiveSizes.sidebarWidth(this);
  int get projectsPerRow => ResponsiveSizes.projectsPerRow(this);
  int get tasksPerRow => ResponsiveSizes.tasksPerRow(this);

  // ========== TEXT STYLES ==========

  TextStyle get bodyStyle =>
      TextStyle(fontSize: fontSizeSm, fontWeight: FontWeight.normal);

  TextStyle get titleLargeStyle =>
      TextStyle(fontSize: fontSizeLg, fontWeight: FontWeight.w600);

  TextStyle get titleMediumStyle =>
      TextStyle(fontSize: fontSizeMd, fontWeight: FontWeight.w500);

  TextStyle get titleSmallStyle =>
      TextStyle(fontSize: fontSizeSm, fontWeight: FontWeight.w500);

  TextStyle get bodyLargeStyle =>
      TextStyle(fontSize: fontSizeMd, fontWeight: FontWeight.normal);

  TextStyle get bodyMediumStyle =>
      TextStyle(fontSize: fontSizeSm, fontWeight: FontWeight.normal);

  TextStyle get bodySmallStyle =>
      TextStyle(fontSize: fontSizeSm - 2, fontWeight: FontWeight.normal);

  TextStyle get labelLargeStyle =>
      TextStyle(fontSize: fontSizeSm, fontWeight: FontWeight.w500);

  TextStyle get labelMediumStyle =>
      TextStyle(fontSize: fontSizeSm - 2, fontWeight: FontWeight.normal);

  // ========== PADDING HELPERS ==========
  EdgeInsetsGeometry get paddingAllSm => EdgeInsets.all(sm);
  EdgeInsetsGeometry get paddingAllMd => EdgeInsets.all(md);
  EdgeInsetsGeometry get paddingAllLg => EdgeInsets.all(lg);

  EdgeInsetsGeometry get paddingHorizontalSm =>
      EdgeInsets.symmetric(horizontal: sm);
  EdgeInsetsGeometry get paddingHorizontalMd =>
      EdgeInsets.symmetric(horizontal: md);
  EdgeInsetsGeometry get paddingHorizontalLg =>
      EdgeInsets.symmetric(horizontal: lg);

  EdgeInsetsGeometry get paddingVerticalSm =>
      EdgeInsets.symmetric(vertical: sm);
  EdgeInsetsGeometry get paddingVerticalMd =>
      EdgeInsets.symmetric(vertical: md);
  EdgeInsetsGeometry get paddingVerticalLg =>
      EdgeInsets.symmetric(vertical: lg);

  EdgeInsetsGeometry get paddingSymmetricDefault =>
      EdgeInsets.symmetric(horizontal: md, vertical: sm);

  // ========== BORDER RADIUS HELPERS ==========
  BorderRadius get borderRadiusSmAll =>
      BorderRadius.all(Radius.circular(borderRadiusSm));
  BorderRadius get borderRadiusMdAll =>
      BorderRadius.all(Radius.circular(borderRadiusMd));
  BorderRadius get borderRadiusLgAll =>
      BorderRadius.all(Radius.circular(borderRadiusLg));

  RoundedRectangleBorder get roundedRectangleSm =>
      RoundedRectangleBorder(borderRadius: borderRadiusSmAll);

  RoundedRectangleBorder get roundedRectangleMd =>
      RoundedRectangleBorder(borderRadius: borderRadiusMdAll);

  RoundedRectangleBorder get roundedRectangleLg =>
      RoundedRectangleBorder(borderRadius: borderRadiusLgAll);

  // ========== METHODS FOR MAX WIDTH ==========
  double get maxContainerWidth => ResponsiveSizes.maxContainerWidth(this);
}
