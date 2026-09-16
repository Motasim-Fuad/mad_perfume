import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/commerce_models.dart';
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
                Text(
                  order.number,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  order.status.replaceAll('_', ' '),
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
