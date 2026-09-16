import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/di/locator.dart';
import 'package:madperfume/features/cart/presentation/pages/cart_page.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/home/presentation/pages/home_page.dart';
import 'package:madperfume/features/home/presentation/cubit/home_cubit.dart';
import 'package:madperfume/features/loyalty/presentation/pages/loyalty_page.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/features/products/presentation/pages/category_page.dart';
import 'package:madperfume/features/profile/presentation/pages/profile_page.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/features/shell/presentation/cubit/shell_cubit.dart';
import 'package:madperfume/shared/widgets/custom_bottom_nav.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShellCubit()),
        BlocProvider(create: (_) => sl<HomeCubit>()..load()),
        BlocProvider(create: (_) => sl<CategoryCubit>()..load()),
        BlocProvider(create: (_) => sl<LoyaltyCubit>()..load()),
        BlocProvider(create: (_) => sl<ProfileHomeCubit>()..load()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.background,
          extendBody: true,
          body: PageView(
            controller: context.read<ShellCubit>().pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: context.read<ShellCubit>().setTabFromPage,
            children: const [
              HomePage(),
              CategoryPage(),
              CartPage(),
              LoyaltyPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: const CustomBottomNav(),
        ),
      ),
    );
  }
}
