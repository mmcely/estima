import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/stat_card.dart';

Widget FirstRow(
  BuildContext context,
  Map<String, dynamic> userData,
  Map<String, dynamic> dashboardStats,
  int selectedYear,
) {
  return Responsive(
    mobile: Column(
      children: [
        _buildWelcomeCard(context, userData, dashboardStats),
        SizedBox(height: context.lg),
        _buildStatsRow(context, dashboardStats),
      ],
    ),
    tablet: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildWelcomeCard(context, userData, dashboardStats),
        ),
        SizedBox(width: context.lg),
        Expanded(flex: 1, child: _buildStatsRow(context, dashboardStats)),
      ],
    ),
    desktop: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildWelcomeCard(context, userData, dashboardStats),
        ),
        SizedBox(width: context.xl),
        Expanded(flex: 1, child: _buildStatsRow(context, dashboardStats)),
      ],
    ),
  );
}

Widget _buildWelcomeCard(
  BuildContext context,
  Map<String, dynamic> userData,
  Map<String, dynamic> dashboardStats,
) {
  final userName = userData['name']?.split(' ')[0] ?? 'User';
  final teamMembers = userData['teamMembers'] ?? 0;
  final tasks = userData['tasks'] ?? 0;
  final projects = userData['projects'] ?? 0;

  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Congratulations $userName! 🎉',
                    style: context.titleLargeStyle.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: context.md),
                  Text(
                    'You have ${dashboardStats['monthlyGrowth']?.toStringAsFixed(1) ?? '72.8'}% more sales today.\n'
                    'Leading a team of $teamMembers members with $tasks active tasks.',
                  ),
                  SizedBox(height: context.xl),

                  // Quick stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildWelcomeStat(
                        context,
                        label: 'Projects',
                        value: projects.toString(),
                        color: AppColors.primary,
                      ),
                      _buildWelcomeStat(
                        context,
                        label: 'Tasks',
                        value: tasks.toString(),
                        color: AppColors.success,
                      ),
                      _buildWelcomeStat(
                        context,
                        label: 'Team',
                        value: teamMembers.toString(),
                        color: AppColors.warning,
                      ),
                      SizedBox(width: context.xs),
                    ],
                  ),

                  SizedBox(height: context.xl),

                  ElevatedButton(
                    onPressed: () => Get.toNamed('/my_profile'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: context.borderRadiusMdAll,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.lg,
                        vertical: context.sm,
                      ),
                    ),
                    child: Text('View Profile', style: context.titleSmallStyle),
                  ),
                ],
              ),
            ),
            if (!context.isMobile)
              SizedBox(
                width:
                    MediaQuery.of(context).size.width >= 768 &&
                        MediaQuery.of(context).size.width < 1200
                    ? 120
                    : 150,
                height:
                    MediaQuery.of(context).size.width >= 768 &&
                        MediaQuery.of(context).size.width < 1200
                    ? 120
                    : 150,
                child: Image.asset(userData['avatar'] ?? '', fit: BoxFit.cover),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildWelcomeStat(
  BuildContext context, {
  required String label,
  required String value,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: context.titleLargeStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
      SizedBox(height: context.xs),
      Text(label),
    ],
  );
}

Widget _buildStatsRow(
  BuildContext context,
  Map<String, dynamic> dashboardStats,
) {
  return Column(
    children: [
      StatCard(
        title: 'Profit',
        value:
            '\$${dashboardStats['totalRevenue']?.toStringAsFixed(0) ?? '12,628'}',
        change:
            '+${dashboardStats['monthlyGrowth']?.toStringAsFixed(1) ?? '72.8'}%',
        isPositive: true,
        icon: Icons.trending_up_rounded,
        iconColor: AppColors.success,
        backgroundColor: AppColors.success.withOpacity(0.1),
      ),
      SizedBox(height: context.lg),
      StatCard(
        title: 'Sales',
        value: '\$4,679',
        change: '+28.42%',
        isPositive: true,
        icon: Icons.shopping_bag_outlined,
        iconColor: AppColors.primary,
        backgroundColor: AppColors.primary.withOpacity(0.1),
      ),
    ],
  );
}
