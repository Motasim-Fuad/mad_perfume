import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShellController>();
    return Material(
      type: MaterialType.transparency,
      child: Obx(() {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: AppSizes.navHeight,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _Item(
                    index: 0,
                    icon: Icons.home_rounded,
                    label: 'home'.tr,
                    selected: controller.tabIndex.value == 0,
                    onTap: () => controller.setTab(0),
                  ),
                  _Item(
                    index: 1,
                    icon: Icons.shopping_bag_outlined,
                    label: 'products'.tr,
                    selected: controller.tabIndex.value == 1,
                    onTap: () => controller.setTab(1),
                  ),
                  _Item(
                    index: 2,
                    icon: Icons.shopping_cart_outlined,
                    label: 'cart'.tr,
                    selected: controller.tabIndex.value == 2,
                    onTap: () => controller.setTab(2),
                  ),
                  _Item(
                    index: 3,
                    icon: Icons.workspace_premium_outlined,
                    label: 'loyalty'.tr,
                    selected: controller.tabIndex.value == 3,
                    onTap: () => controller.setTab(3),
                  ),
                  _Item(
                    index: 4,
                    icon: Icons.person_outline,
                    label: 'profile'.tr,
                    selected: controller.tabIndex.value == 4,
                    onTap: () => controller.setTab(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      }),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.index,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final int index;
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected ? AppColors.ink : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected ? AppColors.surface : AppColors.inkSoft,
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
