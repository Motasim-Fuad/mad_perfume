import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/products/presentation/widgets/product_list_tile.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductListCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'product_list'.tr,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: AppColors.muted,
                  ),
                ),
                BlocBuilder<ProductListCubit, ProductListState>(
                  builder: (context, state) => Text(
                    state.categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: controller.searchAsYouType,
                        onSubmitted: (value) => controller.load(search: value),
                        decoration: InputDecoration(
                          hintText: 'search_products'.tr,
                          prefixIcon: const Icon(Icons.search, size: 20),
                          filled: true,
                          fillColor: AppColors.surfaceMuted,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    BlocBuilder<ProductListCubit, ProductListState>(
                      builder: (context, state) => TextButton(
                        onPressed: controller.toggleSort,
                        child: Text(
                          controller.newest ? 'sort_newest'.tr : 'price'.tr,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ProductListCubit, ProductListState>(
              builder: (context, state) => QueryBody(
                loading: state.loading,
                error: state.error,
                empty: state.items.isEmpty,
                emptyMessage: 'no_results'.tr,
                onRetry: controller.load,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final product = state.items[index];
                    return ProductListTile(
                      product: product,
                      onTap: () => controller.open(product.id),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
