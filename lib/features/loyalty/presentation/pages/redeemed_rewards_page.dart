import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/loyalty_controller.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

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
