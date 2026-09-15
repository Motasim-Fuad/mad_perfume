import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/products/presentation/controllers/product_list_controller.dart';
import 'package:madperfume/features/products/presentation/widgets/product_list_tile.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class ProductListPage extends GetView<ProductListController> {
  const ProductListPage({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'product_list'.tr,
                  style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 2, color: AppColors.muted),
                ),
                Text(
                  controller.collection.nameKey.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) => controller.search.value = value,
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
                    Obx(
                      () => TextButton(
                        onPressed: controller.sortNewest.toggle,
                        child: Text(
                          controller.sortNewest.value ? 'sort_newest'.tr : 'price'.tr,
                          style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1),
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
            child: Obx(() {
              final items = controller.items;
              if (items.isEmpty) {
                return EmptyWidget(message: 'empty_saved'.tr);
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductListTile(
                    product: product,
                    onTap: () => controller.openDetails(product.id),
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
