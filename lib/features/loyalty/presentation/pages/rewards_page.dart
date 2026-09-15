import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/rewards_controller.dart';
import 'package:madperfume/features/loyalty/presentation/widgets/reward_list_card.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class RewardsPage extends GetView<RewardsController> {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Obx(
            () => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    '${controller.session.points.value}',
                    style: GoogleFonts.cormorantGaramond(color: Colors.white, fontSize: 40),
                  ),
                  Text('total_points_available'.tr, style: GoogleFonts.dmSans(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text('exclusive_rewards'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600)),
          Text('exclusive_rewards_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted)),
          const SizedBox(height: 12),
          ...CatalogData.rewards.map(
            (reward) => RewardListCard(
              reward: reward,
              onTap: () => controller.open(reward.id),
            ),
          ),
        ],
      ),
    );
  }
}
