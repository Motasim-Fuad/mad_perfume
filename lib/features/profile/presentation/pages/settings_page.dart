import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/controllers/settings_controller.dart';
import 'package:madperfume/features/profile/presentation/widgets/settings_tile.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('settings'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          SettingsTile(label: 'edit_profile'.tr, onTap: controller.editProfile),
          SettingsTile(label: 'security'.tr, onTap: controller.security),
          SettingsTile(label: 'notifications'.tr, onTap: controller.notifications),
          SettingsTile(label: 'logout'.tr, onTap: controller.logout, danger: true),
        ],
      ),
    );
  }
}
