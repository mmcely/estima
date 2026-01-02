import 'package:flutter/material.dart';

import 'dashboard_card.dart';
import '../../../core/responsive/responsive_extensions.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      padding: EdgeInsets.all(context.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: context.borderRadiusMdAll,
                ),
                child: Icon(icon, color: iconColor, size: context.iconSm),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (_) {},
                itemBuilder: (context) => ['See more', 'Stat'].map((item) {
                  return PopupMenuItem(value: item, child: Text(item));
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: context.md),
          Text(title, style: context.bodyStyle.copyWith()),
          SizedBox(height: context.xs),
          Text(
            value,
            style: context.titleLargeStyle.copyWith(
              fontSize: context.fontSizeLg * 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.sm),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? Colors.green : Colors.red,
                size: context.iconXs,
              ),
              SizedBox(width: 4),
              Text(
                change,
                style: context.bodySmallStyle.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
