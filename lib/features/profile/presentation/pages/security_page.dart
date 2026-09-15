import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/controllers/security_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class SecurityPage extends GetView<SecurityController> {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('update_password'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          AppField(controller: controller.current.controller, label: 'current_password'.tr, obscure: true),
          const SizedBox(height: 12),
          AppField(controller: controller.next.controller, label: 'new_password'.tr, obscure: true),
          const SizedBox(height: 12),
          AppField(controller: controller.confirm.controller, label: 'confirm_password'.tr, obscure: true),
          const SizedBox(height: 22),
          Obx(
            () => AppButton(
              label: 'update_password_btn'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.updatePassword,
            ),
          ),
        ],
      ),
    );
  }
}
