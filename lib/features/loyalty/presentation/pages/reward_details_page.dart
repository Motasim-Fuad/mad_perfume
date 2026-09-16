import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class RewardDetailsPage extends StatelessWidget {
  const RewardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RewardDetailCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<RewardDetailCubit, RewardDetailState>(
        builder: (context, state) => QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              if (state.reward case final reward?) ...[
                Text(
                  'reward_details'.tr,
                  style: GoogleFonts.dmSans(
                    letterSpacing: 2,
                    fontSize: 11,
                    color: AppColors.muted,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: RemoteImage(
                      url: reward.imageUrl,
                      label: 'reward image here',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  reward.category,
                  style: GoogleFonts.dmSans(
                    letterSpacing: 1.4,
                    fontSize: 11,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  reward.name,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
                Text(
                  '${reward.pointsRequired} pts',
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  reward.description,
                  style: GoogleFonts.dmSans(
                    height: 1.5,
                    color: AppColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  reward.eligibility,
                  style: GoogleFonts.dmSans(color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                if (state.voucher case final voucher?) ...[
                  GlossyCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'voucher_code'.tr,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: AppColors.muted,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SelectableText(
                          voucher.voucherCode,
                          style: GoogleFonts.dmSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'reward_claim_copy'.tr,
                          style: GoogleFonts.dmSans(
                            color: AppColors.inkSoft,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                AppButton(
                  label: state.voucher != null
                      ? 'redeemed'.tr
                      : 'redeem_now'.tr,
                  loading: state.busy,
                  error: state.actionError,
                  onPressed: reward.canRedeem && state.voucher == null
                      ? controller.redeem
                      : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
