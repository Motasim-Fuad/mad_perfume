import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/features/loyalty/presentation/widgets/reward_list_card.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/query_body.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RewardsCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<RewardsCubit, RewardsState>(
        builder: (context, state) => QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, auth) => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.ink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${auth.profile?.pointsBalance ?? 0}',
                        style: GoogleFonts.cormorantGaramond(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        'total_points_available'.tr,
                        style: GoogleFonts.dmSans(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'exclusive_rewards'.tr,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'exclusive_rewards_copy'.tr,
                style: GoogleFonts.dmSans(color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              Column(
                children: state.items
                    .map(
                      (reward) => RewardListCard(
                        reward: reward,
                        onTap: () => controller.open(reward.id),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
