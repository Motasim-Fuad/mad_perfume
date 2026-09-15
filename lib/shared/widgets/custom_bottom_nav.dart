import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/app_sizes.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';
import 'package:madperfume/shared/widgets/bottom_nav_item.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShellController>();
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SizedBox(
              height: AppSizes.navHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Obx(
                  () => Row(
                    children: [
                      BottomNavItem(
                        icon: Icons.home_outlined,
                        label: 'home'.tr,
                        selected: controller.tabIndex.value == 0,
                        onTap: () => controller.setTab(0),
                      ),
                      BottomNavItem(
                        icon: Icons.shopping_bag_outlined,
                        label: 'products'.tr,
                        selected: controller.tabIndex.value == 1,
                        onTap: () => controller.setTab(1),
                      ),
                      BottomNavItem(
                        icon: Icons.shopping_cart_outlined,
                        label: 'cart'.tr,
                        selected: controller.tabIndex.value == 2,
                        onTap: () => controller.setTab(2),
                      ),
                      BottomNavItem(
                        icon: Icons.workspace_premium_outlined,
                        label: 'loyalty'.tr,
                        selected: controller.tabIndex.value == 3,
                        onTap: () => controller.setTab(3),
                      ),
                      BottomNavItem(
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
          ),
        ),
      ),
    );
  }
}
