import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/profile/presentation/widgets/settings_tile.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'settings'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SettingsTile(
            label: 'edit_profile'.tr,
            onTap: () => Get.toNamed(AppRoutes.editProfile),
          ),
          SettingsTile(
            label: 'security'.tr,
            onTap: () => Get.toNamed(AppRoutes.security),
          ),
          SettingsTile(
            label: 'notifications'.tr,
            onTap: () => Get.toNamed(AppRoutes.notificationSettings),
          ),
          SettingsTile(
            label: 'logout'.tr,
            onTap: context.read<AuthCubit>().logout,
            danger: true,
          ),
        ],
      ),
    );
  }
}
