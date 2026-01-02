import 'package:estima/state/auth_controller.dart';
import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_extensions.dart';

Widget SuccessMessage(
  BuildContext context, {
  required AuthController authController,
}) {
  return Container(
    width: context.isMobile ? double.infinity : 400,
    padding: EdgeInsets.all(context.lg),
    decoration: BoxDecoration(
      color: Colors.white,
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
        Icon(
          Icons.check_circle_outline,
          size: context.iconLg * 2,
          color: Colors.green,
        ),
        SizedBox(height: context.lg),
        Text(
          'Email Sent Successfully!',
          style: context.titleLargeStyle.copyWith(
            fontSize: context.fontSizeLg * 1.3,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.md),
        Text(
          'We\'ve sent password reset instructions to your email. '
          'Please check your inbox and follow the link to reset your password.',
          style: context.bodyStyle.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.xl),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => authController.resetForgotPasswordState(),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: context.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: context.borderRadiusMdAll,
                  ),
                ),
                child: Text('Send Again'),
              ),
            ),
            SizedBox(width: context.md),
            Expanded(
              child: ElevatedButton(
                onPressed: () => authController.navigateToLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF696CFF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: context.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: context.borderRadiusMdAll,
                  ),
                ),
                child: Text('Back to Login'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
