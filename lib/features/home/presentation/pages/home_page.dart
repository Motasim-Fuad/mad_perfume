import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/features/home/presentation/controllers/home_controller.dart';
import 'package:madperfume/features/home/presentation/widgets/boutique_preview.dart';
import 'package:madperfume/features/home/presentation/widgets/collection_strip.dart';
import 'package:madperfume/features/home/presentation/widgets/featured_product_card.dart';
import 'package:madperfume/features/home/presentation/widgets/home_hero_carousel.dart';
import 'package:madperfume/features/home/presentation/widgets/home_top_bar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeTopBar()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      '${'hello'.tr.split(',').first}, ${controller.firstName}',
                      style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.muted),
                    ),
                  ),
                  Text(
                    'discover_scent'.tr,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const HomeSearchField(),
                  const SizedBox(height: 18),
                  HomeHeroCarousel(
                    products: controller.featured,
                    onOpen: controller.openProduct,
                  ),
                  const SizedBox(height: 22),
                  CollectionStrip(
                    collections: controller.collections,
                    onViewAll: controller.openAllCollections,
                    onOpen: controller.openCollection,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'featured'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            sliver: SliverList.separated(
              itemCount: controller.featured.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final product = controller.featured[index];
                return FeaturedProductCard(
                  product: product,
                  onTap: () => controller.openProduct(product.id),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, AppSizes.navClearance),
              child: BoutiquePreview(
                branches: controller.boutiques,
                onViewAll: controller.openBranches,
                onOpen: controller.openBranch,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.search),
      child: AbsorbPointer(
        child: TextField(
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
    );
  }
}
