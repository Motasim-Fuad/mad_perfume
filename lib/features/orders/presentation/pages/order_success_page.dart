import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class OrderSuccessPage extends GetView<OrderFlowController> {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(color: AppColors.ink, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 24),
          Text(
            'order_successful'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            'order_success_body'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.45),
          ),
          const Spacer(),
          AppButton(label: 'track_order'.tr, onPressed: controller.track),
          const SizedBox(height: 12),
          AppButton(label: 'back_to_home'.tr, outlined: true, onPressed: controller.home),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
