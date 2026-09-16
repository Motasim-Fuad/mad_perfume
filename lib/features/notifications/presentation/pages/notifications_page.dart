import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<NotificationsCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'notifications'.tr,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'notifications_subtitle'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) => Row(
                    children: [
                      _tab('all_updates'.tr, null, state.category, controller),
                      _tab('offers'.tr, 'offers', state.category, controller),
                      _tab('reward'.tr, 'rewards', state.category, controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                final items = state.items;
                return QueryBody(
                  loading: state.loading,
                  error: state.error,
                  empty: items.isEmpty,
                  onRetry: () => controller.load(category: state.category),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GlossyCard(
                        onTap: () => controller.open(item),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.ink,
                              child: Icon(
                                item.category == 'rewards'
                                    ? Icons.workspace_premium_outlined
                                    : Icons.local_shipping_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    item.body,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 13,
                                      color: AppColors.inkSoft,
                                      height: 1.35,
                                    ),
                                  ),
                                  Text(
                                    item.createdAt,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 10,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(
    String label,
    String? category,
    String? selectedCategory,
    NotificationsCubit controller,
  ) {
    final selected = category == selectedCategory;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip(
          selected: selected,
          label: FittedBox(child: Text(label)),
          onSelected: (_) => controller.load(category: category),
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
