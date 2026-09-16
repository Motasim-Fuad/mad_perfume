import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) {
        return;
      }
      final loggedIn = context.read<AuthCubit>().state.isLoggedIn;
      Get.offAllNamed(loggedIn ? AppRoutes.main : AppRoutes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF7F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: Image.asset(
                'assets/icon/app_icon.png',
                width: 168,
                height: 168,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 36),
            Text(
              'app_name'.tr,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 22,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'tagline'.tr,
              style: GoogleFonts.dmSans(
                fontSize: 10,
                letterSpacing: 3.2,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
