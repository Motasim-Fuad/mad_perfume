import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/products/presentation/controllers/category_controller.dart';
import 'package:madperfume/features/products/presentation/widgets/collection_banner.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text(
            'product_category'.tr,
            style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 2.2, color: AppColors.muted),
          ),
          const SizedBox(height: 10),
          Text(
            'the_collections'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(fontSize: 34, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'collections_intro'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(fontSize: 13, height: 1.45, color: AppColors.muted),
          ),
          const SizedBox(height: 22),
          ...controller.collections.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: CollectionBanner(collection: item, onTap: () => controller.open(item.id)),
            ),
          ),
        ],
      ),
    );
  }
}
