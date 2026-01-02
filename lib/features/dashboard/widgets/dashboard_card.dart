import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/helpers.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;

  const DashboardCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
    this.elevation = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.light,
        borderRadius: BorderRadius.circular(context.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: dark ? AppColors.dark : Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
