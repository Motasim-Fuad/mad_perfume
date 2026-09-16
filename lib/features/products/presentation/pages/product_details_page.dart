import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/products/presentation/widgets/product_reviews_block.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/app_toast.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductDetailsCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listenWhen: (before, after) =>
            before.cartAddSuccess != after.cartAddSuccess,
        listener: (context, state) =>
            AppToast.success(context, 'product_added_successfully'.tr),
        builder: (context, state) => QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          onRefresh: controller.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              if (state.product case final product?) ...[
                Text(
                  'product_details'.tr,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: AppColors.muted,
                  ),
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
                  product.concentrationLabel,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    letterSpacing: 1.8,
                    color: AppColors.muted,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                        ),
                      ),
                    ),
                    MoneyText(product.price, size: 18),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.notes
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceMuted,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    height: 1.55,
                    color: AppColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 16),
                GlossyCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'available_at'.tr,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                      Text(
                        product.branches.map((item) => item.name).join(', '),
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                ProductReviewsBlock(product: product, reviews: state.reviews),
                const SizedBox(height: 22),
                AppButton(
                  label: 'add_to_cart'.tr,
                  loading: state.busy,
                  error: state.actionError,
                  onPressed: product.inStock ? controller.addToCart : null,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
