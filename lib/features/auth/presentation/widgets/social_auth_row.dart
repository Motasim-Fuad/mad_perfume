import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key, required this.onGoogle, required this.onApple});

  final VoidCallback onGoogle;
  final VoidCallback onApple;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Chip(label: 'google'.tr, onTap: onGoogle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Chip(label: 'apple'.tr, onTap: onApple, dark: true),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.onTap, this.dark = false});

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
