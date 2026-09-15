import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class ShippingJourney extends StatelessWidget {
  const ShippingJourney({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = ['order_placed'.tr, 'processing'.tr, 'shipped'.tr, 'in_transit'.tr];
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: i <= 3 ? AppColors.ink : AppColors.line,
                  child: Icon(Icons.check, size: 14, color: i <= 3 ? Colors.white : AppColors.muted),
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
          if (i != steps.length - 1) const Expanded(child: Divider(color: AppColors.ink)),
        ],
      ],
    );
  }
}
