import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/controllers/auth_controller.dart';
import 'package:madperfume/features/auth/presentation/widgets/otp_boxes.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class ResetPasswordPage extends GetView<AuthController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'reset_password'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(fontSize: 34, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              'reset_password_body'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.muted, height: 1.45),
            ),
            const SizedBox(height: 28),
            OtpBoxes(controller: controller.code),
            const SizedBox(height: 28),
            Obx(
              () => AppButton(
                label: 'verify_code'.tr,
                loading: controller.loading.value,
                error: controller.actionError.value,
                onPressed: controller.verifyCode,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'didnt_receive'.tr,
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.muted),
            ),
            Obx(() {
              final wait = controller.resendSeconds.value;
              return TextButton(
                onPressed: wait == 0 ? controller.resend : null,
                child: Text(
                  wait == 0 ? 'resend_code'.tr : 'resend_in'.trArgs(['$wait']),
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    color: AppColors.ink,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
