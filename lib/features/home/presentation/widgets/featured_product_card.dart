import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard({super.key, required this.product, required this.onTap});

  final ProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionStore>();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: AspectRatio(
              aspectRatio: 0.86,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RemoteImage(url: product.imageUrl),
                  PositionedDirectional(
                    top: 12,
                    end: 12,
                    child: Obx(() {
                      final saved = session.wishlist.contains(product.id);
                      return Material(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => session.toggleSaved(product.id),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              saved ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.volume,
                  style: GoogleFonts.dmSans(fontSize: 10, letterSpacing: 1.4, color: AppColors.muted),
                ),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                MoneyText(product.price, size: 14, weight: FontWeight.w600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
