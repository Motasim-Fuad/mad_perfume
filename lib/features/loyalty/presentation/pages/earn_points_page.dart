import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/loyalty/presentation/widgets/earn_step_row.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class EarnPointsPage extends StatelessWidget {
  const EarnPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text(
            'earn_points_title'.tr,
            style: GoogleFonts.dmSans(
              letterSpacing: 1.6,
              fontSize: 11,
              color: AppColors.muted,
            ),
          ),
          Text(
            'elevate_senses'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'earn_intro'.tr,
            style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.45),
          ),
          const SizedBox(height: 18),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'in_app_purchases'.tr,
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
                Text(
                  'in_app_copy'.tr,
                  style: GoogleFonts.dmSans(
                    color: AppColors.muted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'physical_boutiques'.tr,
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
                Text(
                  'physical_copy'.tr,
                  style: GoogleFonts.dmSans(
                    color: AppColors.muted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'rewards_experience'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          EarnStepRow(
            number: '01',
            title: 'step_browse'.tr,
            body: 'step_browse_copy'.tr,
          ),
          EarnStepRow(
            number: '02',
            title: 'step_collect'.tr,
            body: 'step_collect_copy'.tr,
          ),
          EarnStepRow(
            number: '03',
            title: 'step_redeem'.tr,
            body: 'step_redeem_copy'.tr,
          ),
        ],
      ),
    );
  }
}
