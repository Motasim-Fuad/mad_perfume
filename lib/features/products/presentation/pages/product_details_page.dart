import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/products/presentation/controllers/product_details_controller.dart';
import 'package:madperfume/features/products/presentation/widgets/product_reviews_block.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class ProductDetailsPage extends GetView<ProductDetailsController> {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text(
            'product_details'.tr,
            style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 2, color: AppColors.muted),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 0.92,
              child: RemoteImage(url: product.imageUrl),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'eau_de_parfum'.tr,
            style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.8, color: AppColors.muted),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: GoogleFonts.cormorantGaramond(fontSize: 32, fontWeight: FontWeight.w600, height: 1.1),
                ),
              ),
              MoneyText(product.price, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: product.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.dmSans(fontSize: 10, letterSpacing: 0.8),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            product.description,
            style: GoogleFonts.dmSans(fontSize: 14, height: 1.55, color: AppColors.inkSoft),
          ),
          const SizedBox(height: 16),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'available_at'.tr,
                  style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.muted),
                ),
                Text(
                  product.availableAt,
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          ProductReviewsBlock(product: product),
          const SizedBox(height: 22),
          AppButton(label: 'add_to_cart'.tr, onPressed: controller.addToCart),
        ],
      ),
    );
  }
}
