import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/loyalty_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

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
          Text('earn_points_title'.tr, style: GoogleFonts.dmSans(letterSpacing: 1.6, fontSize: 11, color: AppColors.muted)),
          Text('elevate_senses'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 32, fontWeight: FontWeight.w600, height: 1.1)),
          const SizedBox(height: 8),
          Text('earn_intro'.tr, style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.45)),
          const SizedBox(height: 18),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('in_app_purchases'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                Text('in_app_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('physical_boutiques'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                Text('physical_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('rewards_experience'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _step('01', 'step_browse'.tr, 'step_browse_copy'.tr),
          _step('02', 'step_collect'.tr, 'step_collect_copy'.tr),
          _step('03', 'step_redeem'.tr, 'step_redeem_copy'.tr),
        ],
      ),
    );
  }

  Widget _step(String n, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(n, style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                Text(body, style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            (reward) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GestureDetector(
                onTap: () => controller.open(reward.id),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.4,
                        child: RemoteImage(url: reward.imageUrl, label: 'reward image here'),
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
                                  Text(reward.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                                  Text('${reward.points} pts', style: GoogleFonts.dmSans(color: AppColors.muted)),
                                ],
                              ),
                            ),
                            Text('redeem'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class RedeemedRewardsPage extends StatelessWidget {
  const RedeemedRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Get.find<LoyaltyController>().session;
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Obx(() {
        final ids = session.redeemed.toList();
        if (ids.isEmpty) {
          return EmptyWidget(message: 'empty_rewards'.tr);
        }
        final rewards = CatalogData.rewards.where((item) => ids.contains(item.id)).toList();
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Text('your_exclusive'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...rewards.map(
              (reward) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(width: 52, height: 52, child: RemoteImage(url: reward.imageUrl)),
                ),
                title: Text(reward.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text('${reward.points} pts'),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class PointsHistoryPage extends GetView<PointsHistoryController> {
  const PointsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Row(
                children: [
                  _chip('all', 'filter'.tr, controller),
                  _chip('earned', 'earned'.tr, controller),
                  _chip('spent', 'spent'.tr, controller),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.items;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final entry = items[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(entry.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(entry.date),
                    trailing: Text(
                      '${entry.type.name == 'earned' ? '+' : '-'}${entry.points}',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _chip(String id, String label, PointsHistoryController controller) {
    final selected = controller.filter.value == id;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
        onSelected: (_) => controller.filter.value = id,
        selectedColor: AppColors.ink,
        labelStyle: GoogleFonts.dmSans(color: selected ? Colors.white : AppColors.ink),
      ),
    );
  }
}
