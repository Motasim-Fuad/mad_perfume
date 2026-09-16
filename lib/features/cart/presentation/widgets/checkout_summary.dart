import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/constants/commerce_rules.dart';
import 'package:madperfume/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, checkout) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final subtotal = state.cart.subtotal;
            final voucherAmount =
                checkout.selectedVoucher?.resolvedDiscount ?? 0;
            final discount = CommerceRules.appliedDiscount(
              subtotal,
              voucherAmount,
            );
            final tax = CommerceRules.taxOn(
              CommerceRules.taxable(subtotal, discount: voucherAmount),
            );
            return GlossyCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'order_summary'.tr,
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ...state.cart.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item.name}  ${item.variant}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          MoneyText(item.lineTotal, size: 13),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  _row('shipping'.tr, null, trailing: 'free'.tr),
                  if (discount > 0) _row('discount'.tr, discount, prefix: '- '),
                  _row('taxes'.tr, tax),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'total'.tr,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      MoneyText(
                        CommerceRules.previewTotal(
                          subtotal,
                          discount: voucherAmount,
                        ),
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _row(String label, double? value, {String? trailing, String? prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
            )
          else ...[
            if (prefix != null)
              Text(
                prefix,
                style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
              ),
            MoneyText(value ?? 0, size: 13, weight: FontWeight.w600),
          ],
        ],
      ),
    );
  }
}
