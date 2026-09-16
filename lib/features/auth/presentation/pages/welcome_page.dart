import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/locale_service.dart';
import 'package:madperfume/features/auth/presentation/widgets/welcome_hero.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<LocaleService>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 16),
          child: Column(
            children: [
              const BrandHeader(
                centerTitle: true,
                trailing: SizedBox(width: 12),
              ),
              const SizedBox(height: 8),
              const Expanded(child: WelcomeHero()),
              const SizedBox(height: 22),
              Text(
                'welcome_body'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.inkSoft,
                ),
              ),
              const SizedBox(height: 22),
              AppButton(
                label: 'sign_up'.tr,
                onPressed: () => Get.toNamed(AppRoutes.register),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'login'.tr,
                outlined: true,
                onPressed: () => Get.toNamed(AppRoutes.login),
              ),
              const SizedBox(height: 16),
              Text(
                '${'terms_prefix'.tr} ${'terms'.tr}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(
                  fontSize: 9,
                  letterSpacing: 1.1,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
