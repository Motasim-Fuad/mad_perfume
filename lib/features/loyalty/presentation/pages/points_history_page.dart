import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/features/loyalty/presentation/widgets/history_filter_chip.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/query_body.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class PointsHistoryPage extends StatelessWidget {
  const PointsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HistoryCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) => Row(
                children: [
                  HistoryFilterChip(
                    id: 'all',
                    label: 'filter'.tr,
                    selected: state.filter == 'all',
                    onSelected: (id) => controller.load(filter: id),
                  ),
                  HistoryFilterChip(
                    id: 'earned',
                    label: 'earned'.tr,
                    selected: state.filter == 'earned',
                    onSelected: (id) => controller.load(filter: id),
                  ),
                  HistoryFilterChip(
                    id: 'spent',
                    label: 'spent'.tr,
                    selected: state.filter == 'spent',
                    onSelected: (id) => controller.load(filter: id),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                final items = state.items;
                return QueryBody(
                  loading: state.loading,
                  error: state.error,
                  empty: items.isEmpty,
                  onRetry: () => controller.load(filter: state.filter),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    itemCount: items.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final entry = items[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          entry.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(entry.createdAt),
                        trailing: Text(
                          '${entry.points > 0 ? '+' : ''}${entry.points}',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                          ),
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
}
