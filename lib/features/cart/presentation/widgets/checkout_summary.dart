import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/presentation/controllers/cart_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();
    return Obx(() {
      controller.usePoints.value;
      controller.session.cart.length;
      return GlossyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('order_summary'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...controller.session.cart.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name}  ${item.volume}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MoneyText(item.lineTotal, size: 13),
                  ],
                ),
              ),
            ),
            const Divider(),
            _row('shipping'.tr, null, trailing: 'free'.tr),
            _row('taxes'.tr, controller.tax),
            if (controller.discount > 0) _row('points_discount'.tr, -controller.discount),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text('total'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w800)),
                ),
                MoneyText(controller.total, size: 18),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _row(String label, double? value, {String? trailing}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13))),
          if (trailing != null)
            Text(trailing, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600))
          else
            MoneyText(value ?? 0, size: 13, weight: FontWeight.w600),
        ],
      ),
    );
  }
}
