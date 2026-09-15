import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/orders/presentation/controllers/write_review_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class WriteReviewPage extends GetView<WriteReviewController> {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('write_a_review'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Obx(
            () => Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () => controller.rating.value = index + 1,
                  icon: Icon(
                    index < controller.rating.value ? Icons.star : Icons.star_border,
                  ),
                ),
              ),
            ),
          ),
          AppField(
            controller: controller.body.controller,
            label: 'share_thoughts'.tr,
            hint: 'review_hint'.tr,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          Obx(
            () => AppButton(
              label: 'publish_review'.tr,
              error: controller.error.value,
              onPressed: controller.submit,
            ),
          ),
        ],
      ),
    );
  }
}
