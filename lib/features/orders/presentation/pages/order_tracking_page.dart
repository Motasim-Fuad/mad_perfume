import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';
import 'package:madperfume/features/orders/presentation/widgets/amount_row.dart';
import 'package:madperfume/features/orders/presentation/widgets/shipping_journey.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/money_text.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class OrderTrackingPage extends GetView<OrderFlowController> {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = controller.order;
    final eta = '${order.eta.month}/${order.eta.day}/${order.eta.year}';
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text(
            'order_tracking'.tr,
            style: GoogleFonts.dmSans(letterSpacing: 2, fontSize: 12, color: AppColors.muted),
          ),
          Text(
            'track_your_order'.tr,
            style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Text(
            'order_in_transit_copy'.trArgs([order.id, eta]),
            style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4),
          ),
          const SizedBox(height: 18),
          const ShippingJourney(),
          const SizedBox(height: 22),
          Text('order_details'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ...order.items.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(item.volume),
              trailing: MoneyText(item.lineTotal, size: 14),
            ),
          ),
          const Divider(),
          AmountRow(label: 'subtotal'.tr, value: order.subtotal),
          AmountRow(label: 'shipping'.tr, value: 0, free: true, freeLabel: 'free'.tr),
          AmountRow(label: 'total'.tr, value: order.total, bold: true),
          const SizedBox(height: 16),
          Text('shipping_journey'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          GlossyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('delivery_address'.tr, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.muted)),
                Text(order.fullName, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                Text(order.address),
                const SizedBox(height: 12),
                Text('payment'.tr, style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.muted)),
                Text(order.cardMasked),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
