import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_extensions.dart';
import '../../../core/utils/colors.dart';
import '../../../data/models/dashboard_model.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/transaction_item.dart';

Widget ThirdRow(BuildContext context, Map<String, dynamic> userData) {
  return Responsive(
    mobile: Column(
      children: [
        _buildOrderStatistics(context),
        SizedBox(height: context.lg),
        _buildExpenseOverview(context),
        SizedBox(height: context.lg),
        _buildTransactions(context),
      ],
    ),
    tablet: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _buildOrderStatistics(context)),
            SizedBox(width: context.lg),
            Expanded(flex: 1, child: _buildExpenseOverview(context)),
          ],
        ),
        SizedBox(height: context.lg),
        _buildTransactions(context),
      ],
    ),
    desktop: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _buildOrderStatistics(context)),
        SizedBox(width: context.lg),
        Expanded(flex: 1, child: _buildExpenseOverview(context)),
        SizedBox(width: context.lg),
        Expanded(flex: 1, child: _buildTransactions(context)),
      ],
    ),
  );
}

Widget _buildOrderStatistics(BuildContext context) {
  final List<Map<String, dynamic>> orders = [
    {
      'category': 'Electronic',
      'value': '82.5k',
      'sub': 'Mobile, Earbuds, TV',
      'color': AppColors.primary,
    },
    {
      'category': 'Fashion',
      'value': '23.8k',
      'sub': 'T-shirt, Jeans, Shoes',
      'color': AppColors.success,
    },
    {
      'category': 'Decor',
      'value': '849k',
      'sub': 'Fine Art, Dining',
      'color': AppColors.accent,
    },
    {
      'category': 'Sports',
      'value': '99',
      'sub': 'Football, Cricket Kit',
      'color': AppColors.warning,
    },
  ];

  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: orders.map((order) {
        final color = order['color'] as Color;

        return Padding(
          padding: EdgeInsets.only(bottom: context.md),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: context.borderRadiusMdAll,
                ),
                child: Icon(
                  _getCategoryIcon(order['category']!),
                  color: color,
                  size: context.iconSm,
                ),
              ),
              SizedBox(width: context.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['category']!,
                      style: context.titleSmallStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      order['sub']!,
                      style: context.bodySmallStyle.copyWith(),
                    ),
                  ],
                ),
              ),
              Text(
                order['value']!,
                style: context.titleMediumStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

IconData _getCategoryIcon(String category) {
  switch (category) {
    case 'Electronic':
      return Icons.smartphone_outlined;
    case 'Fashion':
      return Icons.checkroom_outlined;
    case 'Decor':
      return Icons.home_outlined;
    case 'Sports':
      return Icons.sports_soccer_outlined;
    default:
      return Icons.category_outlined;
  }
}

Widget _buildExpenseOverview(BuildContext context) {
  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tabs
        DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                labelColor: AppColors.primaryLight,
                indicatorColor: AppColors.primaryLight,
                tabs: const [
                  Tab(text: 'Income'),
                  Tab(text: 'Expenses'),
                  Tab(text: 'Profit'),
                ],
              ),
              SizedBox(height: context.lg),

              SizedBox(
                height: 200,
                child: TabBarView(
                  children: [
                    // Income Tab
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: context.borderRadiusMdAll,
                              ),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                color: AppColors.primary,
                                size: context.iconSm,
                              ),
                            ),
                            SizedBox(width: context.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: context.bodyStyle.copyWith(),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '\$459.10',
                                        style: context.titleLargeStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: context.sm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.sm,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.success.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius:
                                              context.borderRadiusSmAll,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.trending_up_rounded,
                                              color: AppColors.success,
                                              size: context.iconXs,
                                            ),
                                            SizedBox(width: 2),
                                            Text(
                                              '42.9%',
                                              style: context.bodySmallStyle
                                                  .copyWith(
                                                    color: AppColors.success,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.lg),

                        Expanded(
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(
                              labelStyle: context.bodySmallStyle,
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: context.bodySmallStyle,
                            ),
                            series: <CartesianSeries>[
                              ColumnSeries<ChartData, String>(
                                dataSource: [
                                  ChartData('Mon', 1200),
                                  ChartData('Tue', 1800),
                                  ChartData('Wed', 1500),
                                  ChartData('Thu', 2200),
                                  ChartData('Fri', 1900),
                                  ChartData('Sat', 2500),
                                  ChartData('Sun', 2100),
                                ],
                                xValueMapper: (ChartData data, _) => data.month,
                                yValueMapper: (ChartData data, _) => data.value,
                                color: AppColors.primaryLight,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: context.lg),
                        Center(
                          child: Text(
                            'Income this week: \$5,300',
                            style: context.bodyStyle.copyWith(),
                          ),
                        ),
                      ],
                    ),

                    // Expenses Tab
                    Center(child: Text('Expenses Content')),

                    // Profit Tab
                    Center(child: Text('Profit Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransactions(BuildContext context) {
  final transactions = [
    {
      'type': 'Paypal',
      'description': 'Send money',
      'amount': '+82.6',
      'icon': Icons.payment_outlined,
      'color': AppColors.primary,
    },
    {
      'type': 'Wallet',
      'description': 'Mac\'D',
      'amount': '+270.69',
      'icon': Icons.account_balance_wallet_outlined,
      'color': AppColors.success,
    },
    {
      'type': 'Transfer',
      'description': 'Refund',
      'amount': '+637.91',
      'icon': Icons.swap_horiz_outlined,
      'color': AppColors.accent,
    },
    {
      'type': 'Credit Card',
      'description': 'Ordered Food',
      'amount': '-838.71',
      'icon': Icons.credit_card_outlined,
      'color': AppColors.warning,
    },
    {
      'type': 'Wallet',
      'description': 'Starbucks',
      'amount': '+203.33',
      'icon': Icons.account_balance_wallet_outlined,
      'color': AppColors.success,
    },
    {
      'type': 'Mastercard',
      'description': 'Ordered Food',
      'amount': '-92.45',
      'icon': Icons.credit_score_outlined,
      'color': AppColors.error,
    },
  ];

  return DashboardCard(
    padding: EdgeInsets.all(context.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions',
              style: context.titleLargeStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (_) {},
              itemBuilder: (context) =>
                  ['Last 28 Days', 'Last Month', 'Last Year'].map((item) {
                    return PopupMenuItem(value: item, child: Text(item));
                  }).toList(),
            ),
          ],
        ),
        SizedBox(height: context.lg),

        Column(
          children: transactions.map((transaction) {
            return TransactionItem(
              type: transaction['type']!.toString(),
              description: transaction['description']!.toString(),
              amount: transaction['amount']!.toString(),
              icon: transaction['icon'] as IconData,
              iconColor: transaction['color'] as Color,
              isPositive: transaction['amount']!.toString().startsWith('+'),
            );
          }).toList(),
        ),
      ],
    ),
  );
}
