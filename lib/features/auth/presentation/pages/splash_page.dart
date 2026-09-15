import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/session_store.dart';

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
      final loggedIn = Get.find<SessionStore>().isLoggedIn;
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
            Container(
              width: 168,
              height: 168,
              decoration: BoxDecoration(
                color: AppColors.lilac,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lilacDeep.withValues(alpha: 0.45),
                    blurRadius: 28,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MAD',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 42,
                      color: Colors.white,
                      letterSpacing: 6,
                      height: 1,
                    ),
                  ),
                  Text(
                    'PARFUMEUR',
                    style: GoogleFonts.dmSans(
                      fontSize: 10,
                      color: Colors.white,
                      letterSpacing: 3.5,
                    ),
                  ),
                ],
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
