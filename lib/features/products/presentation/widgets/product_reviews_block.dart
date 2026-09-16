import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/catalog_models.dart';

class ProductReviewsBlock extends StatelessWidget {
  const ProductReviewsBlock({
    super.key,
    required this.product,
    required this.reviews,
  });

  final ProductModel product;
  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'reviews'.tr,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, size: 16, color: AppColors.ink),
            const SizedBox(width: 4),
            Text(
              product.rating.toStringAsFixed(1),
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'based_on'.trArgs(['${product.reviewsCount}']),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: AppColors.muted,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...reviews.map(
          (review) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review.userName,
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 14,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  review.createdAt,
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    letterSpacing: 1,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  review.comment,
                  style: GoogleFonts.dmSans(
                    height: 1.45,
                    color: AppColors.inkSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
