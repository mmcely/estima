import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/common/app_text_field.dart';
import '../../../state/auth_controller.dart';

Widget ResetPasswordForm(BuildContext context) {
  final AuthController authController =
      GetInstance().isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  return Container(
    width: context.isMobile ? double.infinity : 400,
    padding: EdgeInsets.all(context.lg),
    decoration: BoxDecoration(
      color: AppColors.darkGrey.withOpacity(0.25),
      borderRadius: context.borderRadiusLgAll,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 20,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Form(
      key: authController.newPasswordFormKey,
      child: Column(
        children: [
          // Title
          Row(
            children: [
              Icon(
                Icons.lock_reset_outlined,
                color: AppColors.primaryLight,
                size: context.iconMd,
              ),
              SizedBox(width: context.sm),
              Text(
                'Reset Password 🔒',
                style: context.titleLargeStyle.copyWith(
                  fontSize: context.fontSizeLg * 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: context.sm),

          // Description
          Text(
            'Enter your new password',
            style: context.bodyStyle.copyWith(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.sm),

          // New Password Field
          Obx(
            () => AppTextField(
              controller: authController.passwordController,
              label: 'Password',
              hint: '••••••••••••',
              onChanged: (_) => authController.update(),
              icon: Icons.lock_outline,
              validator: (value) => AppValidator.validatePassword(value),
              obscureText: true,
              showPasswordToggle: true,
              isPasswordVisible: !authController.obscurePassword.value,
              onTogglePassword: () => authController.togglePasswordVisibility(),
            ),
          ),
          SizedBox(height: context.sm),

          // Confirm Password Field
          Obx(
            () => AppTextField(
              controller: authController.confirmPasswordController,
              label: 'Confirm Password',
              hint: '••••••••••••',
              onChanged: (_) => authController.update(),
              icon: Icons.lock_outline,
              validator: (value) => AppValidator.validateConfirmPassword(
                value,
                authController.confirmPasswordController.text,
              ),
              obscureText: true,
              showPasswordToggle: true,
              isPasswordVisible: !authController.obscureConfirmPassword.value,
              onTogglePassword: () => authController.togglePasswordVisibility(),
            ),
          ),
          SizedBox(height: context.sm * 1.5),

          // Reset Password Button
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    AppValidator.validatePassword(
                          authController.passwordController.text,
                        ) ==
                        null
                    ? () async {
                        await authController.handleNewPassword();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: context.buttonHeight * 0.3,
                  ),
                ),
                child: Text(
                  'Reset Password',
                  style: context.titleMediumStyle.copyWith(),
                ),
              ),
            ),
          ),
          SizedBox(height: context.sm),

          // Back to Login
          TextButton.icon(
            onPressed: () async {
              await authController.navigateToLogin();
            },
            icon: Icon(Icons.arrow_back_ios, size: context.iconSm),
            label: Text(
              'Back to login',
              style: context.bodyStyle.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    ),
  );
}
