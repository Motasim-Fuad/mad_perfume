import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: selected ? 4 : 2,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 480),
          curve: const Cubic(0.16, 1, 0.3, 1),
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: selected ? AppColors.ink : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: selected ? AppColors.surface : const Color(0xFF9A8F86),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 480),
                  curve: const Cubic(0.16, 1, 0.3, 1),
                  alignment: AlignmentDirectional.centerStart,
                  child: selected
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8),
                          child: Text(
                            label.toUpperCase(),
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w700,
                              color: AppColors.surface,
                            ),
                          ),
                        )
                      : const SizedBox(width: 0, height: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
