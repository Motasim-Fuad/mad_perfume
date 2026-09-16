import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/models/catalog_models.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class BranchListCard extends StatelessWidget {
  const BranchListCard({super.key, required this.branch, required this.onTap});

  final BranchModel branch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.7,
              child: RemoteImage(
                url: branch.imageUrl,
                label: 'boutique image here',
              ),
            ),
            Container(
              width: double.infinity,
              color: AppColors.surface,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch.name,
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    branch.address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      color: AppColors.muted,
                      fontSize: 12,
                    ),
                  ),
                  Text(branch.hours, style: GoogleFonts.dmSans(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
