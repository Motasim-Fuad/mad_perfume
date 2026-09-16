import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/features/orders/presentation/widgets/amount_row.dart';
import 'package:madperfume/features/orders/presentation/widgets/order_review_item.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';
import 'package:madperfume/shared/widgets/query_body.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              if (state.order case final order?) ...[
                Text(
                  '${order.number} · ${order.status.replaceAll('_', ' ')}',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                AppButton(
                  label: 'track_order'.tr,
                  onPressed: () =>
                      Get.toNamed(AppRoutes.orderTracking, arguments: order.id),
                ),
                const SizedBox(height: 18),
                Column(
                  children: order.items
                      .map(
                        (item) => OrderReviewItem(
                          item: item,
                          reviewed:
                              item.product != null &&
                              state.reviewedProductIds.contains(item.product),
                          canReview:
                              order.status == 'delivered' &&
                              item.product != null,
                          onReview: item.product == null
                              ? () {}
                              : () => controller.review(item.product!),
                        ),
                      )
                      .toList(),
                ),
                const Divider(),
                AmountRow(label: 'subtotal'.tr, value: order.subtotal),
                AmountRow(label: 'taxes'.tr, value: order.tax),
                AmountRow(label: 'total'.tr, value: order.total, bold: true),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
