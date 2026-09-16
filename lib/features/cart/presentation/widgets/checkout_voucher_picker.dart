import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/presentation/widgets/pay_tile.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/shared/widgets/animated_circular_loader.dart';
import 'package:madperfume/shared/widgets/money_text.dart';

class CheckoutVoucherPicker extends StatelessWidget {
  const CheckoutVoucherPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CheckoutCubit>();
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'apply_voucher'.tr,
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'apply_voucher_copy'.tr,
              style: GoogleFonts.dmSans(
                color: AppColors.muted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            if (state.vouchersLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: AnimatedCircularLoader(size: 28)),
              )
            else if (state.voucherError.isNotEmpty)
              Column(
                children: [
                  Text(
                    state.voucherError,
                    style: GoogleFonts.dmSans(
                      color: AppColors.muted,
                      height: 1.4,
                    ),
                  ),
                  TextButton(
                    onPressed: controller.loadVouchers,
                    child: Text('retry'.tr),
                  ),
                ],
              )
            else if (state.vouchers.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'no_usable_vouchers'.tr,
                    style: GoogleFonts.dmSans(
                      color: AppColors.muted,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Get.toNamed(AppRoutes.rewards);
                      if (context.mounted) {
                        await controller.loadVouchers();
                      }
                    },
                    child: Text('redeem_for_voucher'.tr),
                  ),
                ],
              )
            else
              ...state.vouchers.map((voucher) {
                final selected =
                    state.selectedVoucher?.voucherCode == voucher.voucherCode;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: PayTile(
                    label: '${voucher.name}\n${voucher.voucherCode}',
                    selected: selected,
                    onTap: () => controller.selectVoucher(voucher),
                    trailing: voucher.resolvedDiscount > 0
                        ? MoneyText(voucher.resolvedDiscount, size: 14)
                        : null,
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}
