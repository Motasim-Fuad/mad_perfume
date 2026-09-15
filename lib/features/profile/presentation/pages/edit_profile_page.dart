import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('edit_profile'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          AppField(controller: controller.name.controller, label: 'full_name'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.email.controller, label: 'email_address'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.phone.controller, label: 'phone_number'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.address.controller, label: 'address'.tr, maxLines: 3),
          const SizedBox(height: 22),
          Obx(
            () => AppButton(
              label: 'save_changes'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.save,
            ),
          ),
        ],
      ),
    );
  }
}
