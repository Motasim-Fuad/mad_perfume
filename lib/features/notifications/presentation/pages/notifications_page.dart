import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/notifications/presentation/controllers/notifications_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text('notifications'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600)),
                Text(
                  'notifications_subtitle'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Row(
                    children: [
                      _tab('all_updates'.tr, 0),
                      _tab('offers'.tr, 1),
                      _tab('reward'.tr, 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.items;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GlossyCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.imageUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(width: 56, height: 56, child: RemoteImage(url: item.imageUrl!)),
                          )
                        else
                          CircleAvatar(
                            backgroundColor: AppColors.ink,
                            child: Icon(
                              item.category == 'reward' ? Icons.workspace_premium_outlined : Icons.local_shipping_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (item.tag != null)
                                Text(item.tag!, style: GoogleFonts.dmSans(fontSize: 10, letterSpacing: 1, color: AppColors.muted)),
                              Text(item.title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                              Text(item.body, style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.inkSoft, height: 1.35)),
                              Text(item.time, style: GoogleFonts.dmSans(fontSize: 10, color: AppColors.muted)),
                            ],
                          ),
                        ),
                      ],
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

  Widget _tab(String label, int index) {
    final selected = controller.tab.value == index;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip(
          selected: selected,
          label: FittedBox(child: Text(label)),
          onSelected: (_) => controller.tab.value = index,
          selectedColor: AppColors.ink,
          labelStyle: GoogleFonts.dmSans(
            fontSize: 10,
            letterSpacing: 0.6,
            color: selected ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}
