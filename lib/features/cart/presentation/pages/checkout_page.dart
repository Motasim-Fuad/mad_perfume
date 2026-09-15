import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/presentation/controllers/cart_controller.dart';
import 'package:madperfume/features/cart/presentation/widgets/checkout_summary.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text(
            'checkout'.tr,
            style: GoogleFonts.dmSans(letterSpacing: 2.4, fontSize: 12, color: AppColors.muted),
          ),
          Text(
            'checkout_title'.tr,
            style: GoogleFonts.cormorantGaramond(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          Text(
            'checkout_subtitle'.tr,
            style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Text(
            'shipping_information'.tr,
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          AppField(controller: controller.name.controller, label: 'name'.tr, hint: 'enter_your_name'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.address.controller, label: 'street_address'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.city.controller, label: 'city'.tr),
          const SizedBox(height: 22),
          Text(
            'payment_details'.tr,
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Column(
              children: [
                _PayTile(
                  label: 'visa_credit'.tr,
                  selected: controller.useCard.value,
                  onTap: () => controller.useCard.value = true,
                ),
                const SizedBox(height: 8),
                _PayTile(
                  label: 'cash_on_delivery'.tr,
                  selected: !controller.useCard.value,
                  onTap: () => controller.useCard.value = false,
                ),
              ],
            ),
          ),
          Obx(() {
            if (!controller.useCard.value) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 12),
                AppField(
                  controller: controller.card.controller,
                  label: 'card_number'.tr,
                  hint: '4242 **** **** 4242',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                AppField(
                  controller: controller.expiry.controller,
                  label: 'mm_yy'.tr,
                  hint: '12 / 28',
                ),
              ],
            );
          }),
          const SizedBox(height: 18),
          Obx(() {
            final pts = controller.applicable;
            return SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('use_loyalty_points'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
              subtitle: Text(
                'points_available'.trArgs(['$pts']),
                style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted),
              ),
              value: controller.usePoints.value,
              activeThumbColor: AppColors.ink,
              onChanged: pts == 0 ? null : (value) => controller.usePoints.value = value,
            );
          }),
          const SizedBox(height: 8),
          const CheckoutSummary(),
          const SizedBox(height: 18),
          Obx(
            () => AppButton(
              label: 'secure_checkout'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.placeOrder,
            ),
          ),
        ],
      ),
    );
  }
}

class _PayTile extends StatelessWidget {
  const _PayTile({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? AppColors.ink : AppColors.line),
        ),
        child: Row(
          children: [
            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
