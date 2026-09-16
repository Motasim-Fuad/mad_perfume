import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/features/cart/presentation/widgets/checkout_summary.dart';
import 'package:madperfume/features/cart/presentation/widgets/checkout_voucher_picker.dart';
import 'package:madperfume/features/cart/presentation/widgets/pay_tile.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: RefreshIndicator.adaptive(
        onRefresh: controller.refreshAll,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Text(
              'checkout'.tr,
              style: GoogleFonts.dmSans(
                letterSpacing: 2.4,
                fontSize: 12,
                color: AppColors.muted,
              ),
            ),
            Text(
              'checkout_title'.tr,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
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
            AppField(
              controller: controller.name,
              label: 'name'.tr,
              hint: 'enter_your_name'.tr,
            ),
            const SizedBox(height: 12),
            AppField(
              controller: controller.address,
              label: 'street_address'.tr,
            ),
            const SizedBox(height: 12),
            AppField(controller: controller.city, label: 'city'.tr),
            const SizedBox(height: 12),
            AppField(controller: controller.phone, label: 'phone_number'.tr),
            const SizedBox(height: 22),
            Text(
              'payment_details'.tr,
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) => Column(
                children: [
                  PayTile(
                    label: 'visa_credit'.tr,
                    selected: state.useCard,
                    onTap: () => controller.setCard(true),
                  ),
                  const SizedBox(height: 8),
                  PayTile(
                    label: 'cash_on_delivery'.tr,
                    selected: !state.useCard,
                    onTap: () => controller.setCard(false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const CheckoutVoucherPicker(),
            const SizedBox(height: 8),
            const CheckoutSummary(),
            const SizedBox(height: 18),
            BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (context, state) => AppButton(
                label: 'secure_checkout'.tr,
                loading: state.loading,
                error: state.error,
                onPressed: controller.place,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
