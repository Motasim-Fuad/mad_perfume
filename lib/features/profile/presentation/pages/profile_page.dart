import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final orders = controller.orders;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
          children: [
            Center(
              child: Text('profile'.tr.toUpperCase(), style: GoogleFonts.dmSans(letterSpacing: 3, fontWeight: FontWeight.w700)),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                onPressed: controller.openSettings,
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
            Text('order_history'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600)),
            Text('recent_transactions'.tr, style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, color: AppColors.muted)),
            const SizedBox(height: 12),
            if (orders.isEmpty) EmptyWidget(message: 'empty_orders'.tr),
            ...orders.map(
              (order) => GlossyCard(
                onTap: () => controller.openOrder(order.id),
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
              ),
            ),
            const SizedBox(height: 16),
            GlossyCard(
              onTap: controller.openSaved,
              child: Row(
                children: [
                  Expanded(child: Text('saved_items_count'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700))),
                  Text('${controller.session.wishlist.length}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GlossyCard(
              child: Row(
                children: [
                  Expanded(child: Text('tier_status'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700))),
                  Text('platinum'.tr),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
