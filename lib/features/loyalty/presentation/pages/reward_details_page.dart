import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/reward_details_controller.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class RewardDetailsPage extends GetView<RewardDetailsController> {
  const RewardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reward = controller.reward;
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text('reward_details'.tr, style: GoogleFonts.dmSans(letterSpacing: 2, fontSize: 11, color: AppColors.muted)),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(aspectRatio: 1, child: RemoteImage(url: reward.imageUrl, label: 'reward image here')),
          ),
          const SizedBox(height: 16),
          Text(reward.subtitle, style: GoogleFonts.dmSans(letterSpacing: 1.4, fontSize: 11, color: AppColors.muted)),
          Text(reward.title, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600, height: 1.1)),
          Text('${reward.points} pts', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(reward.description, style: GoogleFonts.dmSans(height: 1.5, color: AppColors.inkSoft)),
          const SizedBox(height: 16),
          Text('how_to_use'.tr, style: GoogleFonts.dmSans(letterSpacing: 1.4, fontSize: 12)),
          ...reward.howToUse.asMap().entries.map(
            (entry) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.surfaceMuted,
                child: Text('${entry.key + 1}', style: GoogleFonts.dmSans(color: AppColors.ink)),
              ),
              title: Text(entry.value),
            ),
          ),
          Obx(
            () => AppButton(
              label: controller.already ? 'redeemed'.tr : 'redeem_now'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.already ? null : controller.redeem,
            ),
          ),
        ],
      ),
    );
  }
}
