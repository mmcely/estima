import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/common/app_text_field.dart';
import '../../../state/auth_controller.dart';
import 'success_message.dart';

Widget ForgotPasswordForm(BuildContext context) {
  final AuthController authController =
      GetInstance().isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  return Obx(() {
    if (authController.resetEmailSent.value) {
      return SuccessMessage(context, authController: authController);
    }

    return Form(
      key: authController.resetPasswordFormKey,
      child: Container(
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
        child: Column(
          children: [
            // Title
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  color: AppColors.primary,
                  size: context.iconMd,
                ),
                SizedBox(width: context.sm),
                Text(
                  'Forgot Password? 🔒',
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
              'Enter your email and we\'ll send you instructions to reset your password',
              style: context.bodyStyle.copyWith(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.sm),

            // Email Field
            AppTextField(
              controller: authController.emailController,
              label: 'Email',
              hint: 'Enter your email',
              icon: Icons.email_outlined,
              validator: (value) => AppValidator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: context.sm * 1.5),

            // Send Reset Link Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await authController.handlePasswordReset();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: context.buttonHeight * 0.3,
                  ),
                ),
                child: Text(
                  'Send Reset Link',
                  style: context.titleMediumStyle.copyWith(),
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
  });
}
