import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/features/orders/presentation/widgets/amount_row.dart';
import 'package:madperfume/features/orders/presentation/widgets/shipping_journey.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/money_text.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OrderDetailCubit>();
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) => QueryBody(
          loading: state.loading,
          error: state.error,
          onRetry: controller.load,
          onRefresh: controller.load,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              if (state.order case final order?) ...[
                Text(
                  'order_tracking'.tr,
                  style: GoogleFonts.dmSans(
                    letterSpacing: 2,
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  'track_your_order'.tr,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'order_in_transit_copy'.trArgs([
                    order.number,
                    order.estimatedDelivery,
                  ]),
                  style: GoogleFonts.dmSans(
                    color: AppColors.muted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                ShippingJourney(status: order.status),
                const SizedBox(height: 22),
                Text(
                  'order_details'.tr,
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                ...order.items.map(
                  (item) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(item.variant),
                    trailing: MoneyText(item.lineTotal, size: 14),
                  ),
                ),
                const Divider(),
                AmountRow(label: 'subtotal'.tr, value: order.subtotal),
                if (order.discount > 0)
                  AmountRow(label: 'discount'.tr, value: order.discount),
                AmountRow(
                  label: 'shipping'.tr,
                  value: 0,
                  free: true,
                  freeLabel: 'free'.tr,
                ),
                AmountRow(label: 'total'.tr, value: order.total, bold: true),
                const SizedBox(height: 16),
                Text(
                  'shipping_journey'.tr,
                  style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                GlossyCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'delivery_address'.tr,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                      Text(
                        order.shippingName,
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                      ),
                      Text('${order.shippingAddress}, ${order.shippingCity}'),
                      const SizedBox(height: 12),
                      Text(
                        'payment'.tr,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                      Text(
                        order.paymentMethod == 'cod'
                            ? 'cash_on_delivery'.tr
                            : '•••• ${order.cardLast4 ?? ''}',
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
