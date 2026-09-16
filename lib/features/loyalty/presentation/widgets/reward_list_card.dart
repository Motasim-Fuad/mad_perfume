import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/loyalty_models.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class RewardListCard extends StatelessWidget {
  const RewardListCard({super.key, required this.reward, required this.onTap});

  final RewardModel reward;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.4,
                child: RemoteImage(
                  url: reward.imageUrl,
                  label: 'reward image here',
                ),
              ),
              Container(
                width: double.infinity,
                color: AppColors.surface,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${reward.pointsRequired} pts',
                            style: GoogleFonts.dmSans(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      reward.canRedeem ? 'redeem'.tr : 'unavailable'.tr,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        color: reward.canRedeem
                            ? AppColors.ink
                            : AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
