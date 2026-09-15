import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/cart/presentation/controllers/cart_controller.dart';
import 'package:madperfume/features/cart/presentation/widgets/cart_line_item.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = controller.session;
    return SafeArea(
      child: Obx(() {
        final items = session.cart.toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                children: [
                  Text(
                    'cart'.tr.toUpperCase(),
                    style: GoogleFonts.dmSans(letterSpacing: 3, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'shopping_bag'.tr,
                      style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'items_in_collection'.trArgs(['${session.cartCount}']),
                      style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? EmptyWidget(message: 'empty_cart'.tr)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const Divider(height: 28),
                      itemBuilder: (context, index) => CartLineItem(item: items[index]),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'subtotal'.tr,
                          style: GoogleFonts.dmSans(letterSpacing: 1.4, fontWeight: FontWeight.w700),
                        ),
                      ),
                      MoneyText(session.cartTotal, size: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'proceed_checkout'.tr,
                    onPressed: items.isEmpty ? null : controller.checkout,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
