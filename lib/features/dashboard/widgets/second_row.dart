import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../data/models/dashboard_model.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/stat_card.dart';

Widget SecondRow(
  BuildContext context,
  Map<String, dynamic> userData,
  Map<String, dynamic> dashboardStats,
  int selectedYear,
  String selectedChartFilter,
  void Function(void Function()) setStateCallback,
) {
  return Responsive(
    mobile: Column(
      children: [
        _buildRevenueChart(
          context,
          dashboardStats,
          selectedYear,
          selectedChartFilter,
          setStateCallback,
        ),
        SizedBox(height: context.lg),
        _buildSmallStatsRow(context, userData, dashboardStats),
      ],
    ),
    tablet: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildRevenueChart(
            context,
            dashboardStats,
            selectedYear,
            selectedChartFilter,
            setStateCallback,
          ),
        ),
        SizedBox(width: context.lg),
        Expanded(
          flex: 1,
          child: _buildSmallStatsRow(context, userData, dashboardStats),
        ),
      ],
    ),
    desktop: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildRevenueChart(
            context,
            dashboardStats,
            selectedYear,
            selectedChartFilter,
            setStateCallback,
          ),
        ),
        SizedBox(width: context.xl),
        Expanded(
          flex: 1,
          child: _buildSmallStatsRow(context, userData, dashboardStats),
        ),
      ],
    ),
  );
}

Widget _buildRevenueChart(
  BuildContext context,
  Map<String, dynamic> dashboardStats,
  int selectedYear,
  String selectedChartFilter,
  void Function(void Function()) setStateCallback,
) {
  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Revenue',
              style: context.titleLargeStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                setStateCallback(() {
                  // This function will be called from the parent
                });
              },
              itemBuilder: (context) =>
                  ['Year', 'Month', 'Week', 'Day'].map((filter) {
                    return PopupMenuItem(value: filter, child: Text(filter));
                  }).toList(),
            ),
          ],
        ),
        SizedBox(height: context.lg),

        // Chart
        Container(
          height: context.isMobile ? 200 : 250,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(labelStyle: context.bodySmallStyle),
            primaryYAxis: NumericAxis(
              labelStyle: context.bodySmallStyle,
              numberFormat: NumberFormat.compactCurrency(
                symbol: '\$',
                decimalDigits: 0,
              ),
            ),
            series: <CartesianSeries>[
              LineSeries<ChartData, String>(
                dataSource: [
                  ChartData('Jan', 25000),
                  ChartData('Feb', 32000),
                  ChartData('Mar', 28000),
                  ChartData('Apr', 35000),
                  ChartData('May', 42000),
                  ChartData('Jun', 38000),
                  ChartData('Jul', 45000),
                  ChartData('Aug', 52000),
                  ChartData('Sep', 48000),
                  ChartData('Oct', 55000),
                  ChartData('Nov', 62000),
                  ChartData('Dec', 58000),
                ],
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                color: AppColors.primaryLight,
                width: 2,
                markerSettings: const MarkerSettings(isVisible: true),
              ),
            ],
          ),
        ),

        // Information below chart
        SizedBox(height: context.lg),
        Divider(height: 1),
        SizedBox(height: context.lg),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Growth Rate', style: context.bodyStyle.copyWith()),
                SizedBox(height: context.xs),
                Text(
                  '${dashboardStats['teamPerformance']?.toStringAsFixed(1) ?? '62'}%',
                  style: context.titleLargeStyle.copyWith(
                    fontSize: context.fontSizeLg * 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Company Growth',
                  style: context.bodySmallStyle.copyWith(),
                ),
              ],
            ),

            Row(
              children: [
                _buildYearComparison(
                  context,
                  year: (selectedYear - 1).toString(),
                  value: '\$32.5k',
                  color: AppColors.primaryLight,
                ),
                SizedBox(width: context.lg),
                _buildYearComparison(
                  context,
                  year: (selectedYear - 2).toString(),
                  value: '\$41.2k',
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildYearComparison(
  BuildContext context, {
  required String year,
  required String value,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(context.sm),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: context.borderRadiusSmAll,
        ),
        child: Icon(
          Icons.attach_money_rounded,
          color: color,
          size: context.iconMd,
        ),
      ),
      SizedBox(height: context.sm),
      Text(year, style: context.bodySmallStyle.copyWith()),
      Text(
        value,
        style: context.titleMediumStyle.copyWith(fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget _buildSmallStatsRow(
  BuildContext context,
  Map<String, dynamic> userData,
  Map<String, dynamic> dashboardStats,
) {
  return Column(
    children: [
      StatCard(
        title: 'Payments',
        value: '\$2,456',
        change: '-14.82%',
        isPositive: false,
        icon: Icons.payment_outlined,
        iconColor: AppColors.warning,
        backgroundColor: AppColors.warning.withOpacity(0.1),
      ),
      SizedBox(height: context.lg),
      StatCard(
        title: 'Transactions',
        value: '\$14,857',
        change: '+28.14%',
        isPositive: true,
        icon: Icons.swap_horiz_outlined,
        iconColor: AppColors.accent,
        backgroundColor: AppColors.accent.withOpacity(0.1),
      ),
      SizedBox(height: context.lg),
      _buildProfileReport(context, userData, dashboardStats),
    ],
  );
}

Widget _buildProfileReport(
  BuildContext context,
  Map<String, dynamic> userData,
  Map<String, dynamic> dashboardStats,
) {
  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userData['name']}\'s Report',
                      style: context.titleMediumStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: context.xs),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.sm,
                        vertical: context.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: context.borderRadiusSmAll,
                      ),
                      child: Text(
                        '${userData['role']} • ${userData['company']}',
                        style: context.bodySmallStyle.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.md),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: AppColors.success,
                          size: context.iconSm,
                        ),
                        SizedBox(width: context.xs),
                        Flexible(
                          child: Text(
                            '+${dashboardStats['teamPerformance']?.toStringAsFixed(1) ?? '68.2'}%',
                            style: context.bodyStyle.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.xs),
                    Text(
                      '\$${dashboardStats['totalRevenue']?.toStringAsFixed(0) ?? '84,686k'}',
                      style: context.titleLargeStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: context.fontSizeMd * 1.1,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.lg),

        // Mini circular chart
        Container(
          height: 80,
          alignment: Alignment.center,
          child: SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: [
                  ChartData(
                    'Completed',
                    dashboardStats['completedTasks']?.toDouble() ?? 47,
                  ),
                  ChartData(
                    'Pending',
                    ((userData['tasks'] ?? 0) -
                            (dashboardStats['completedTasks'] ?? 47))
                        .toDouble(),
                  ),
                ],
                xValueMapper: (ChartData data, _) => data.month,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) {
                  return data.month == 'Completed'
                      ? AppColors.primaryLight
                      : AppColors.darkerGrey;
                },
                innerRadius: '70%',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
