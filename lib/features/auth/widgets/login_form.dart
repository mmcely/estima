import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/responsive/responsive_extensions.dart';

import '../../../core/widgets/common/app_text_field.dart';
import '../../../state/auth_controller.dart';

Widget LoginForm(BuildContext context) {
  final AuthController authController =
      GetInstance().isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  return Form(
    key: authController.loginFormKey,
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
          // Email Field
          AppTextField(
            controller: authController.emailController,
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            validator: (value) => AppValidator.validateEmail(value),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: context.lg),

          // Password Field
          Obx(
            () => AppTextField(
              controller: authController.passwordController,
              label: 'Password',
              hint: '••••••••••••',
              icon: Icons.lock_outline,
              validator: (value) => AppValidator.validatePassword(value),
              obscureText: true,
              showPasswordToggle: true,
              isPasswordVisible: !authController.obscurePassword.value,
              onTogglePassword: () => authController.togglePasswordVisibility(),
            ),
          ),
          SizedBox(height: context.sm),

          // Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember Me
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: authController.rememberMe.value,
                      onChanged: (value) =>
                          authController.rememberMe.value = value ?? false,
                      activeColor: AppColors.primary,
                    ),
                    Text('Remember Me', style: context.bodyStyle),
                  ],
                ),
              ),

              // Forgot Password
              TextButton(
                onPressed: () async {
                  await authController.navigateToForgotPassword();
                },
                child: Text(
                  'Forgot Password?',
                  style: context.bodyStyle.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: context.sm),

          // Login Button
          Obx(
            () => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authController.isLoading.value
                    ? null
                    : () async {
                        await authController.handleEmailLogin();
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: context.buttonHeight * 0.3,
                  ),
                ),
                child: authController.isLoading.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'Sign In',
                        style: context.titleMediumStyle.copyWith(
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
