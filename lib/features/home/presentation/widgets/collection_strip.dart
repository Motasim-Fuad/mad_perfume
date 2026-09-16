import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class CollectionStrip extends StatelessWidget {
  const CollectionStrip({
    super.key,
    required this.collections,
    required this.onViewAll,
    required this.onOpen,
  });

  final List<CategoryModel> collections;
  final VoidCallback onViewAll;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'all_collection'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'view_all'.tr,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  letterSpacing: 1.2,
                  color: AppColors.muted,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 92,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: collections.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final item = collections[index];
              return GestureDetector(
                onTap: () => onOpen(item.id),
                child: SizedBox(
                  width: 72,
                  child: Column(
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 58,
                          height: 58,
                          child: RemoteImage(
                            url: item.imageUrl,
                            label: 'collection image here',
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
