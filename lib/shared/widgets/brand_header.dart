import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.showBack = false,
    this.trailing,
    this.centerTitle = true,
  });

  final bool showBack;
  final Widget? trailing;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: Get.back,
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.ink,
              ),
            )
          else
            const SizedBox(width: 12),
          Expanded(
            child: Text(
              'app_name'.tr,
              textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 3.2,
              ),
            ),
          ),
          trailing ?? const SizedBox(width: 48),
        ],
      ),
    );
  }
}
