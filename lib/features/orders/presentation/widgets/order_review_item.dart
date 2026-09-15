import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/data/models/cart_item.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/money_text.dart';

class OrderReviewItem extends StatelessWidget {
  const OrderReviewItem({
    super.key,
    required this.item,
    required this.reviewed,
    required this.onReview,
  });

  final CartItem item;
  final bool reviewed;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlossyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        item.volume,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                MoneyText(item.lineTotal, size: 13),
              ],
            ),
            const SizedBox(height: 8),
            if (reviewed)
              Text(
                'already_reviewed'.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted),
              )
            else
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: onReview,
                  child: Text(
                    'write_a_review'.tr,
                    style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
