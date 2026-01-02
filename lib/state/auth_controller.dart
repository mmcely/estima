import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/images.dart';
import '../core/utils/validators.dart';
import '../core/widgets/common/loaders.dart';

class AuthController extends GetxController {
  // Text controllers for authentication forms
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();

  // Login specific
  final RxBool rememberMe = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool resetEmailSent = false.obs;

  // Form key for validation
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

  // ==================== UTILITY METHODS ====================

  /// Toggles password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Toggles confirm password visibility
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  /// Toggles new password visibility
  void toggleNewPasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// Shows success message
  void showSuccess(String message) {
    AppLoaders.successSnackBar(title: 'Success', message: message);
  }

  /// Shows error message
  void showError(String message) {
    AppLoaders.errorSnackBar(title: 'Error', message: message);
  }

  /// Shows loading indicator
  void showLoading([String? message]) {
    AppLoaders.showLoading(message: message);
  }

  /// Hides loading indicator
  void hideLoading() {
    AppLoaders.hideLoading();
  }

  /// Validates login form
  bool validateLoginForm() {
    if (!loginFormKey.currentState!.validate()) {
      return false;
    }

    final emailError = AppValidator.validateEmail(emailController.text);
    if (emailError != null) {
      showError(emailError);
      return false;
    }

    final passwordError = AppValidator.validatePassword(
      passwordController.text,
    );
    if (passwordError != null) {
      showError(passwordError);
      return false;
    }

    return true;
  }

  /// Validates reset password form
  bool validateResetPasswordForm() {
    if (!resetPasswordFormKey.currentState!.validate()) {
      return false;
    }

    final emailError = AppValidator.validateEmail(resetEmailController.text);
    if (emailError != null) {
      showError(emailError);
      return false;
    }

    return true;
  }

  /// Validates new password form
  bool validateNewPasswordForm() {
    if (!newPasswordFormKey.currentState!.validate()) {
      return false;
    }

    final passwordError = AppValidator.validatePassword(
      passwordController.text,
    );
    if (passwordError != null) {
      showError(passwordError);
      return false;
    }

    final confirmError = AppValidator.validateConfirmPassword(
      confirmPasswordController.text,
      passwordController.text,
    );
    if (confirmError != null) {
      showError(confirmError);
      return false;
    }

    return true;
  }

  // ==================== EMAIL LOGIN ====================

  /// Handles email login
  Future<void> handleEmailLogin() async {
    try {
      // Validate form
      if (!validateLoginForm()) return;

      // Show loading
      isLoading.value = true;
      showLoading('Signing in...');

      // Simulate API call (frontend only)
      await Future.delayed(const Duration(seconds: 2));

      // Success
      hideLoading();
      showSuccess('Welcome back! Login successful.');

      // Save remember me preference
      if (rememberMe.value) {
        // TODO: Implement remember me logic (shared_preferences)
        print('Remember me enabled for: ${emailController.text}');
      }

      // Navigate to dashboard
      Get.offAllNamed('/dashboard');
    } catch (e) {
      // Handle error
      hideLoading();
      showError('Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== PASSWORD RESET ====================

  /// Handles password reset request
  Future<void> handlePasswordReset() async {
    try {
      // Validate form
      if (!validateResetPasswordForm()) return;

      // Show loading
      showLoading('Sending reset instructions...');

      // Simulate API call (frontend only)
      await Future.delayed(const Duration(seconds: 2));

      // Success
      hideLoading();
      resetEmailSent.value = true;

      showSuccess('Reset instructions sent to ${resetEmailController.text}');

      // TODO: Log the event
      print('Password reset requested for: ${resetEmailController.text}');

      // Auto-navigate back to login after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      Get.toNamed('/login');
    } catch (e) {
      // Handle error
      hideLoading();
      showError('Failed to send reset instructions: ${e.toString()}');
    }
  }

  /// Handles new password submission
  Future<void> handleNewPassword({String? token}) async {
    try {
      // Validate form
      if (!validateNewPasswordForm()) return;

      // Show loading
      showLoading('Resetting password...');

      // Simulate API call (frontend only)
      await Future.delayed(const Duration(seconds: 2));

      // Success
      hideLoading();

      // Show success dialog
      showPasswordResetSuccessDialog();

      // Clear forms
      passwordController.clear();
      confirmPasswordController.clear();
      obscurePassword.value = true;
      obscureConfirmPassword.value = true;
    } catch (e) {
      // Handle error
      hideLoading();
      showError('Password reset failed: ${e.toString()}');
    }
  }

  // ==================== SESSION MANAGEMENT ====================

  /// Checks if user is logged in (frontend simulation)
  bool isLoggedIn() {
    // TODO: Implement actual session check
    // For frontend, we can simulate by checking local storage
    return false; // Change based on your session logic
  }

  /// Logs out user
  Future<void> logout() async {
    try {
      showLoading('Logging out...');

      // Simulate logout process
      await Future.delayed(const Duration(seconds: 1));

      // Clear controllers
      clearControllers();

      // TODO: Clear local storage

      hideLoading();
      AppLoaders.infoSnackBar(
        title: 'Logged out',
        message: 'You have been successfully logged out',
      );

      // Navigate to login
      Get.toNamed('/login');
    } catch (e) {
      hideLoading();
      showError('Logout failed: ${e.toString()}');
    }
  }

  // ==================== FORM MANAGEMENT ====================

  /// Clears all controllers
  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    resetEmailController.clear();

    // Reset states
    rememberMe.value = false;
    obscurePassword.value = true;
    obscureConfirmPassword.value = true;
    resetEmailSent.value = false;
  }

  /// Resets forgot password state
  void resetForgotPasswordState() {
    resetEmailSent.value = false;
    resetEmailController.clear();
  }

  /// Navigates to forgot password screen
  Future<void> navigateToForgotPassword() async {
    Get.toNamed('/forgot-password');
  }

  /// Navigates to login screen
  Future<void> navigateToLogin() async {
    // Clear reset state when going back to login
    resetForgotPasswordState();
    Get.toNamed('/login');
  }

  /// Resets password controllers
  void resetPasswordControllers() {
    passwordController.clear();
    confirmPasswordController.clear();
    obscurePassword.value = true;
    obscureConfirmPassword.value = true;
  }

  /// Shows password reset success dialog
  void showPasswordResetSuccessDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 24),
            SizedBox(width: 12),
            Text(
              'Password Reset',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          'Your password has been reset successfully.\n'
          'You can now login with your new password.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed('/login');
            },
            child: Text(
              'Go to Login',
              style: TextStyle(
                color: const Color(0xFF696CFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== MOCK DATA FOR FRONTEND ====================

  /// Gets mock user data for dashboard (frontend only)
  Map<String, dynamic> getMockUserData() {
    return {
      'name': 'Jane Doe',
      'email': 'janedoe@example.com',
      'avatar': AppImages.user,
      'role': 'Project Manager',
      'company': 'ESTIMA Inc.',
      'notifications': 3,
      'projects': 12,
      'tasks': 47,
      'teamMembers': 8,
    };
  }

  /// Gets mock dashboard statistics (frontend only)
  Map<String, dynamic> getMockDashboardStats() {
    return {
      'totalRevenue': 125000,
      'monthlyGrowth': 72.8,
      'activeProjects': 12,
      'completedTasks': 47,
      'teamPerformance': 85.5,
      'upcomingDeadlines': 3,
    };
  }

  @override
  void onClose() {
    super.onClose();
  }
}
