import 'package:flutter/material.dart';

import '../widgets/logo_section.dart';
import '../widgets/forgot_password_form.dart';
import '../../../core/responsive/responsive_extensions.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

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

                // Forgot Password Card
                ForgotPasswordForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
