import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../utils/colors.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: context.maxContainerWidth),
          padding: context.paddingAllLg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error icon
              Container(
                width: context.iconLg * 2.5,
                height: context.iconLg * 2.5,
                decoration: BoxDecoration(
                  borderRadius: context.borderRadiusLgAll,
                  color: Colors.red.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: context.iconLg * 1.5,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: context.sm),

              // Title
              Text(
                '404',
                style: TextStyle(
                  fontSize: context.fontSizeLg * 3,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: context.sm),

              // Subtitle
              Text(
                'Page Not Found',
                style: context.titleLargeStyle.copyWith(
                  fontSize: context.fontSizeLg * 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.sm),

              // Description
              Text(
                'The page you are looking for doesn\'t exist or has been moved.',
                style: context.bodyStyle.copyWith(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.sm * 1.5),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Back button
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.lg,
                        vertical: context.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: context.borderRadiusMdAll,
                      ),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: Text('Go Back', style: context.titleMediumStyle),
                  ),
                  SizedBox(width: context.sm),

                  // Home button
                  ElevatedButton(
                    onPressed: () => Get.offNamed('/dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      //foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.lg,
                        vertical: context.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: context.borderRadiusMdAll,
                      ),
                      elevation: context.buttonElevation,
                    ),
                    child: Text(
                      'Go to Dashboard',
                      style: context.titleMediumStyle.copyWith(),
                    ),
                  ),
                ],
              ),

              // Login link (if not authenticated)
              SizedBox(height: context.sm),
              TextButton(
                onPressed: () => Get.offNamed('/login'),
                child: Text(
                  'Or go to Login page',
                  style: context.bodyStyle.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
