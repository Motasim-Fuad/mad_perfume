import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';
import 'package:madperfume/features/profile/presentation/widgets/order_history_card.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Obx(() {
        final recent = controller.recentOrders;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Center(
              child: Text(
                'profile'.tr.toUpperCase(),
                style: GoogleFonts.dmSans(letterSpacing: 3, fontWeight: FontWeight.w700),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                onPressed: controller.openSettings,
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
            Text(
              'order_history'.tr,
              style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            Text(
              'recent_transactions'.tr,
              style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, color: AppColors.muted),
            ),
            const SizedBox(height: 12),
            if (controller.orders.isEmpty) EmptyWidget(message: 'empty_orders'.tr),
            ...recent.map(
              (order) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OrderHistoryCard(
                  order: order,
                  onTap: () => controller.openOrder(order.id),
                ),
              ),
            ),
            if (controller.orders.isNotEmpty) ...[
              const SizedBox(height: 4),
              AppButton(
                label: 'all_orders'.tr,
                outlined: true,
                onPressed: controller.openAllOrders,
              ),
            ],
            const SizedBox(height: 22),
            Text(
              'others'.tr,
              style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            GlossyCard(
              onTap: controller.openSaved,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'saved_items_count'.tr,
                    style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, color: AppColors.muted),
                  ),
                  Spacer(),
                  Text(
                    '${controller.session.wishlist.length}',
                    style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlossyCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'tier_status'.tr,
                    style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, color: AppColors.muted),
                  ),
                  Spacer(),
                  Text(
                    'platinum'.tr,
                    style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
