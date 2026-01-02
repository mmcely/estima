import 'package:flutter/material.dart';

import '../../../core/responsive/responsive_extensions.dart';

class TransactionItem extends StatelessWidget {
  final String type;
  final String description;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final bool isPositive;

  const TransactionItem({
    super.key,
    required this.type,
    required this.description,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: context.borderRadiusMdAll,
            ),
            child: Icon(icon, color: iconColor, size: context.iconSm),
          ),
          SizedBox(width: context.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(type, style: context.bodySmallStyle.copyWith()),
                Text(
                  description,
                  style: context.titleSmallStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: context.titleMediumStyle.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('USD', style: context.bodySmallStyle.copyWith()),
            ],
          ),
        ],
      ),
    );
  }
}
