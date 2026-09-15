import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/orders/data/models/order_model.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({super.key, required this.order, required this.onTap});

  final OrderModel order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlossyCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.id, style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted)),
                Text(
                  '${order.createdAt.month}/${order.createdAt.day}/${order.createdAt.year}',
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          MoneyText(order.total, size: 14),
        ],
      ),
    );
  }
}
