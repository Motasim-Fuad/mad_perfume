import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/presentation/pages/cart_page.dart';
import 'package:madperfume/features/home/presentation/pages/home_page.dart';
import 'package:madperfume/features/loyalty/presentation/pages/loyalty_page.dart';
import 'package:madperfume/features/products/presentation/pages/category_page.dart';
import 'package:madperfume/features/profile/presentation/pages/profile_page.dart';
import 'package:madperfume/features/shell/presentation/controllers/shell_controller.dart';
import 'package:madperfume/shared/widgets/custom_bottom_nav.dart';

class MainShellPage extends GetView<ShellController> {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => controller.tabIndex.value = index,
        children: const [
          HomePage(),
          CategoryPage(),
          CartPage(),
          LoyaltyPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
