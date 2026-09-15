import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class ForgotPasswordPage extends GetView<AuthController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'forgot_title'.tr,
              style: GoogleFonts.cormorantGaramond(fontSize: 34, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'forgot_body'.tr,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.muted, height: 1.45),
            ),
            const SizedBox(height: 24),
            AppField(
              controller: controller.resetEmail,
              label: 'email_address'.tr,
              hint: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 28),
            Obx(
              () => AppButton(
                label: 'send_code'.tr,
                loading: controller.loading.value,
                error: controller.actionError.value,
                onPressed: controller.sendCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
