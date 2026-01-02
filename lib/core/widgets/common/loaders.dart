import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import '../../responsive/responsive_sizes.dart';

class AppLoaders {
  AppLoaders._();

  // Hide snackbar
  static void hideSnackBar() {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  }

  // Custom responsive toast
  static void customToast({required String message, Duration? duration}) {
    final context = Get.context!;
    final dark = THelperFunctions.isDarkMode(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        content: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizes.md(context),
            vertical: ResponsiveSizes.sm(context),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveSizes.isMobile(context)
                ? ResponsiveSizes.md(context)
                : ResponsiveSizes.xl(context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveSizes.borderRadiusLg(context),
            ),
            color: dark
                ? AppColors.dark.withOpacity(0.9)
                : AppColors.light.withOpacity(0.95),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: ResponsiveSizes.fontSizeSm(context),
                color: dark ? AppColors.white : AppColors.dark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  // Success snackbar
  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    final context = Get.context!;

    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.success,
      snackPosition: position,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(ResponsiveSizes.sm(context)),
      icon: Icon(
        Icons.check_circle,
        color: AppColors.white,
        size: ResponsiveSizes.iconMd(context),
      ),
      borderRadius: ResponsiveSizes.borderRadiusMd(context),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSizes.md(context),
        vertical: ResponsiveSizes.sm(context),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveSizes.fontSizeMd(context),
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      messageText: message.isNotEmpty
          ? Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveSizes.fontSizeSm(context),
                color: AppColors.white.withOpacity(0.9),
              ),
            )
          : null,
    );
  }

  // Warning snackbar
  static void warningSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    final context = Get.context!;

    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.dark,
      backgroundColor: AppColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(ResponsiveSizes.sm(context)),
      icon: Icon(
        Icons.warning_amber,
        color: AppColors.dark,
        size: ResponsiveSizes.iconMd(context),
      ),
      borderRadius: ResponsiveSizes.borderRadiusMd(context),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSizes.md(context),
        vertical: ResponsiveSizes.sm(context),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveSizes.fontSizeMd(context),
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
      ),
      messageText: message.isNotEmpty
          ? Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveSizes.fontSizeSm(context),
                color: AppColors.dark.withOpacity(0.8),
              ),
            )
          : null,
    );
  }

  // Error snackbar
  static void errorSnackBar({
    required String title,
    String message = '',
    int duration = 4,
  }) {
    final context = Get.context!;

    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.error,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(ResponsiveSizes.sm(context)),
      icon: Icon(
        Icons.error_outline,
        color: AppColors.white,
        size: ResponsiveSizes.iconMd(context),
      ),
      borderRadius: ResponsiveSizes.borderRadiusMd(context),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSizes.md(context),
        vertical: ResponsiveSizes.sm(context),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveSizes.fontSizeMd(context),
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      messageText: message.isNotEmpty
          ? Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveSizes.fontSizeSm(context),
                color: AppColors.white.withOpacity(0.9),
              ),
            )
          : null,
    );
  }

  // Information snackbar
  static void infoSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    final context = Get.context!;

    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.info,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(ResponsiveSizes.sm(context)),
      icon: Icon(
        Icons.info_outline,
        color: AppColors.white,
        size: ResponsiveSizes.iconMd(context),
      ),
      borderRadius: ResponsiveSizes.borderRadiusMd(context),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSizes.md(context),
        vertical: ResponsiveSizes.sm(context),
      ),
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveSizes.fontSizeMd(context),
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      messageText: message.isNotEmpty
          ? Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveSizes.fontSizeSm(context),
                color: AppColors.white.withOpacity(0.9),
              ),
            )
          : null,
    );
  }

  // Loading overlay
  static void showLoading({String? message}) {
    final context = Get.context!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(ResponsiveSizes.lg(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveSizes.borderRadiusLg(context),
            ),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
              if (message != null) ...[
                SizedBox(height: ResponsiveSizes.md(context)),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: ResponsiveSizes.fontSizeSm(context),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Hide loading
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  // Toast for quick actions
  static void actionToast({
    required String message,
    IconData? icon,
    Color? color,
  }) {
    final context = Get.context!;
    final dark = THelperFunctions.isDarkMode(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSizes.md(context),
            vertical: ResponsiveSizes.sm(context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveSizes.borderRadiusMd(context),
            ),
            color: color ?? (dark ? AppColors.darkGrey : AppColors.light),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: ResponsiveSizes.iconSm(context),
                  color: dark ? AppColors.white : AppColors.dark,
                ),
                SizedBox(width: ResponsiveSizes.sm(context)),
              ],
              Text(
                message,
                style: TextStyle(
                  fontSize: ResponsiveSizes.fontSizeSm(context),
                  color: dark ? AppColors.white : AppColors.dark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Toast for quick success
  static void successToast({required String message}) {
    actionToast(
      message: message,
      icon: Icons.check_circle,
      color: AppColors.success,
    );
  }

  // Toast for quick error
  static void errorToast({required String message}) {
    actionToast(message: message, icon: Icons.error, color: AppColors.error);
  }

  // Toast for quick warning
  static void warningToast({required String message}) {
    actionToast(
      message: message,
      icon: Icons.warning,
      color: AppColors.warning,
    );
  }
}
