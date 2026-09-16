import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/products/presentation/widgets/collection_banner.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CategoryCubit>();
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) => SafeArea(
        bottom: false,
        child: QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          onRefresh: controller.load,
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              AppSizes.navClearanceOf(context),
            ),
            children: [
              Text(
                'product_category'.tr,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  letterSpacing: 2.2,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'the_collections'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'collections_intro'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 22),
              ...state.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: CollectionBanner(
                    collection: item,
                    onTap: () => controller.open(item.id),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
