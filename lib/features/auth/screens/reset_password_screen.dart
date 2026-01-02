import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/responsive/responsive_extensions.dart';
import '../../../state/auth_controller.dart';
import '../widgets/logo_section.dart';
import '../widgets/reset_password_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? token;

  const ResetPasswordScreen({super.key, this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Reset password controllers when screen loads
    authController.resetPasswordControllers();
  }

  @override
  void dispose() {
    // Clean up if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: context.maxContainerWidth),
          padding: context.paddingAllLg,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Section
                LogoSection(context),
                SizedBox(height: context.spaceBtwItems),

                // Reset Password Card
                ResetPasswordForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
