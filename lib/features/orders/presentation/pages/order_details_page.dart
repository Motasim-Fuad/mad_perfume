import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';
import 'package:madperfume/features/orders/presentation/widgets/amount_row.dart';
import 'package:madperfume/features/orders/presentation/widgets/order_review_item.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class OrderDetailsPage extends GetView<OrderFlowController> {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = controller.order;
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text(
            '${'delivered'.tr} ${order.createdAt.month}/${order.createdAt.day}/${order.createdAt.year}',
            style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          AppButton(
            label: 'track_order'.tr,
            onPressed: () => Get.toNamed(AppRoutes.orderTracking, arguments: order.id),
          ),
          const SizedBox(height: 18),
          Obx(() {
            controller.session.orders.toList();
            final current = controller.order;
            return Column(
              children: current.items
                  .map(
                    (item) => OrderReviewItem(
                      item: item,
                      reviewed: controller.isReviewed(item.productId),
                      onReview: () => controller.review(item.productId),
                    ),
                  )
                  .toList(),
            );
          }),
          const Divider(),
          AmountRow(label: 'subtotal'.tr, value: order.subtotal),
          AmountRow(label: 'taxes'.tr, value: order.tax),
          AmountRow(label: 'total'.tr, value: order.total, bold: true),
        ],
      ),
    );
  }
}
