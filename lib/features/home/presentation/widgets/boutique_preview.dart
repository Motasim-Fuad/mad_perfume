import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/catalog_data.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class BoutiquePreview extends StatelessWidget {
  const BoutiquePreview({
    super.key,
    required this.branches,
    required this.onViewAll,
    required this.onOpen,
  });

  final List<BranchEntity> branches;
  final VoidCallback onViewAll;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'our_boutiques'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'view_all'.tr,
                style: GoogleFonts.dmSans(fontSize: 11, letterSpacing: 1.2, color: AppColors.muted),
              ),
            ),
          ],
        ),
        ...branches.map(
          (branch) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GestureDetector(
              onTap: () => onOpen(branch.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      RemoteImage(url: branch.imageUrl, label: 'boutique image here'),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.45),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: Text(
                            '${branch.name}\n${branch.city}',
                            style: GoogleFonts.cormorantGaramond(
                              color: Colors.white,
                              fontSize: 22,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
