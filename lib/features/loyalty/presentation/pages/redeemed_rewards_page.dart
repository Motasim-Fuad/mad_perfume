import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class RedeemedRewardsPage extends StatelessWidget {
  const RedeemedRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RedemptionsCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<RedemptionsCubit, RedemptionsState>(
        builder: (context, state) {
          return QueryBody(
            loading: state.loading,
            error: state.error,
            empty: state.items.isEmpty,
            emptyMessage: 'empty_rewards'.tr,
            onRetry: controller.load,
            onRefresh: controller.load,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                Text(
                  'your_exclusive'.tr,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'reward_claim_copy'.tr,
                  style: GoogleFonts.dmSans(fontSize: 13, height: 1.45),
                ),
                const SizedBox(height: 12),
                ...state.items.map(
                  (reward) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: RemoteImage(url: reward.imageUrl),
                      ),
                    ),
                    title: Text(
                      reward.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${reward.points} pts · ${reward.voucherCode}\n'
                      '${'status'.tr}: ${reward.status.tr}',
                    ),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
