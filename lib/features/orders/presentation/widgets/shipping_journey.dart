import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class ShippingJourney extends StatelessWidget {
  const ShippingJourney({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final steps = [
      'order_placed'.tr,
      'processing'.tr,
      'shipped'.tr,
      'in_transit'.tr,
    ];
    const ranks = {
      'pending_payment': 0,
      'paid': 0,
      'processing': 1,
      'shipped': 2,
      'delivered': 3,
    };
    final current = ranks[status] ?? 0;
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: i <= current
                      ? AppColors.ink
                      : AppColors.line,
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: i <= current ? Colors.white : AppColors.muted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  steps[i],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(fontSize: 10),
                ),
              ],
            ),
          ),
          if (i != steps.length - 1)
            Expanded(
              child: Divider(
                color: i < current ? AppColors.ink : AppColors.line,
              ),
            ),
        ],
      ],
    );
  }
}
