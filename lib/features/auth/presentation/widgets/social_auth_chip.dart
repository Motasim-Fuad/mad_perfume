import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class SocialAuthChip extends StatelessWidget {
  const SocialAuthChip({
    super.key,
    required this.label,
    required this.onTap,
    this.dark = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? AppColors.ink : AppColors.surface,
      shape: StadiumBorder(
        side: dark ? BorderSide.none : const BorderSide(color: AppColors.line),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Center(
            child: FittedBox(
              child: Text(
                label,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  color: dark ? AppColors.surface : AppColors.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
