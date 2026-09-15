import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/home/presentation/controllers/product_search_controller.dart';
import 'package:madperfume/features/products/presentation/widgets/product_list_tile.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class SearchPage extends GetView<ProductSearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: TextField(
              autofocus: true,
              onChanged: (value) => controller.query.value = value,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'search_hint'.tr,
                hintStyle: GoogleFonts.dmSans(fontSize: 13, color: AppColors.muted),
                prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.results;
              if (items.isEmpty) {
                return EmptyWidget(message: 'no_results'.tr);
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductListTile(
                    product: product,
                    onTap: () => controller.open(product.id),
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
