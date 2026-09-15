import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/loyalty/presentation/controllers/points_history_controller.dart';
import 'package:madperfume/features/loyalty/presentation/widgets/history_filter_chip.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

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
                  HistoryFilterChip(
                    id: 'all',
                    label: 'filter'.tr,
                    selected: controller.filter.value == 'all',
                    onSelected: (id) => controller.filter.value = id,
                  ),
                  HistoryFilterChip(
                    id: 'earned',
                    label: 'earned'.tr,
                    selected: controller.filter.value == 'earned',
                    onSelected: (id) => controller.filter.value = id,
                  ),
                  HistoryFilterChip(
                    id: 'spent',
                    label: 'spent'.tr,
                    selected: controller.filter.value == 'spent',
                    onSelected: (id) => controller.filter.value = id,
                  ),
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
}
