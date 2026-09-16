import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/home/presentation/cubit/home_cubit.dart';
import 'package:madperfume/features/home/presentation/widgets/boutique_preview.dart';
import 'package:madperfume/features/home/presentation/widgets/collection_strip.dart';
import 'package:madperfume/features/home/presentation/widgets/featured_product_card.dart';
import 'package:madperfume/features/home/presentation/widgets/home_hero_carousel.dart';
import 'package:madperfume/features/home/presentation/widgets/home_search_field.dart';
import 'package:madperfume/features/home/presentation/widgets/home_top_bar.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => SafeArea(
        bottom: false,
        child: QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: HomeTopBar()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, auth) => Text(
                          '${'hello'.tr.split(',').first}, ${auth.profile?.firstName ?? ''}',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.muted,
                          ),
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
                        products: state.featured,
                        onOpen: controller.openProduct,
                      ),
                      const SizedBox(height: 22),
                      CollectionStrip(
                        collections: state.categories,
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
                  itemCount: state.featured.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final product = state.featured[index];
                    return FeaturedProductCard(
                      product: product,
                      onTap: () => controller.openProduct(product.id),
                      onToggleSaved: () => controller.toggleSaved(product),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    28,
                    20,
                    AppSizes.navClearanceOf(context),
                  ),
                  child: BoutiquePreview(
                    branches: state.branches,
                    onViewAll: controller.openBranches,
                    onOpen: controller.openBranch,
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
