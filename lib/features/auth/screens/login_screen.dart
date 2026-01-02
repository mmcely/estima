import 'package:flutter/material.dart';

import '../widgets/logo_section.dart';
import '../widgets/welcome_text.dart';
import '../widgets/login_form.dart';

import '../../../core/responsive/responsive_extensions.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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

                // Welcome Text
                WelcomeText(context),
                SizedBox(height: context.md),

                // Login Form
                LoginForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
