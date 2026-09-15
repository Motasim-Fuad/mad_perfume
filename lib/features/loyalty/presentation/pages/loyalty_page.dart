import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/loyalty/data/models/points_entry.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/loyalty_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';

class LoyaltyPage extends GetView<LoyaltyController> {
  const LoyaltyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Obx(() {
        final points = controller.session.points.value;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Center(
              child: Text(
                'loyalty'.tr.toUpperCase(),
                style: GoogleFonts.dmSans(letterSpacing: 3, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'loyalty_member'.tr,
                    style: GoogleFonts.dmSans(color: Colors.white70, letterSpacing: 1.6, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _fmt(points),
                    style: GoogleFonts.cormorantGaramond(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'total_points_available'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 11, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.tier.toUpperCase(),
                    style: GoogleFonts.dmSans(color: Colors.white, letterSpacing: 2, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            GlossyCard(
              onTap: controller.openEarn,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('earn_points'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                  Text('earn_points_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GlossyCard(
              onTap: controller.openRewards,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('redeem_rewards'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                  Text('redeem_rewards_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13)),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text('explore_rewards'.tr, style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text('recent_activity'.tr, style: GoogleFonts.dmSans(letterSpacing: 1.2, fontSize: 12)),
                ),
                TextButton(onPressed: controller.openHistory, child: Text('points_history'.tr)),
              ],
            ),
            ...controller.recent.map(
              (entry) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(entry.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(entry.date),
                trailing: Text(
                  '${entry.type == PointsType.earned ? '+' : '-'}${entry.points}',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: entry.type == PointsType.earned ? AppColors.success : AppColors.danger,
                  ),
                ),
              ),
            ),
            TextButton(onPressed: controller.openRedeemed, child: Text('redeemed_rewards'.tr)),
          ],
        );
      }),
    );
  }

  String _fmt(int value) {
    return value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}
