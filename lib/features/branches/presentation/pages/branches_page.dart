import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/features/branches/presentation/widgets/branch_list_card.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/query_body.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BranchesCubit>();
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
                  'branches'.tr,
                  style: GoogleFonts.dmSans(
                    letterSpacing: 2,
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  'physical_ateliers'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'branches_intro'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: AppColors.muted,
                    height: 1.4,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: controller.search,
                  onSubmitted: controller.searchNow,
                  decoration: InputDecoration(
                    hintText: 'search_city'.tr,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surfaceMuted,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BranchesCubit, BranchesState>(
              builder: (context, state) {
                final items = state.items;
                return QueryBody(
                  loading: state.loading,
                  error: state.error,
                  empty: items.isEmpty,
                  emptyMessage: 'no_results'.tr,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final branch = items[index];
                      return BranchListCard(
                        branch: branch,
                        onTap: () => controller.open(branch.id),
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
