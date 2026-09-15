import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/orders/presentation/controllers/order_flow_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

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

class OrderTrackingPage extends GetView<OrderFlowController> {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = controller.order;
    final eta =
        '${order.eta.month}/${order.eta.day}/${order.eta.year}';
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
          const _Journey(),
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
          _kv('subtotal'.tr, order.subtotal),
          _kv('shipping'.tr, 0, free: true),
          _kv('total'.tr, order.total, bold: true),
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

  Widget _kv(String label, double value, {bool free = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: GoogleFonts.dmSans(fontWeight: bold ? FontWeight.w800 : FontWeight.w500))),
          if (free) Text('free'.tr) else MoneyText(value, size: 14, weight: bold ? FontWeight.w800 : FontWeight.w600),
        ],
      ),
    );
  }
}

class _Journey extends StatelessWidget {
  const _Journey();

  @override
  Widget build(BuildContext context) {
    final steps = ['order_placed'.tr, 'processing'.tr, 'shipped'.tr, 'in_transit'.tr];
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: i <= 3 ? AppColors.ink : AppColors.line,
                  child: Icon(Icons.check, size: 14, color: i <= 3 ? Colors.white : AppColors.muted),
                ),
                const SizedBox(height: 6),
                Text(
                  steps[i],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(fontSize: 10),
                ),
              ],
            ),
          ),
          if (i != steps.length - 1) const Expanded(child: Divider(color: AppColors.ink)),
        ],
      ],
    );
  }
}

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
              children: current.items.map((item) {
                final reviewed = controller.isReviewed(item.productId);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GlossyCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    item.volume,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            MoneyText(item.lineTotal, size: 13),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (reviewed)
                          Text(
                            'already_reviewed'.tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.muted),
                          )
                        else
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: TextButton(
                              onPressed: () => controller.review(item.productId),
                              child: Text(
                                'write_a_review'.tr,
                                style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          const Divider(),
          _line('subtotal'.tr, order.subtotal),
          _line('taxes'.tr, order.tax),
          _line('total'.tr, order.total, bold: true),
        ],
      ),
    );
  }

  Widget _line(String label, double value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: GoogleFonts.dmSans(fontWeight: bold ? FontWeight.w800 : FontWeight.w500))),
          MoneyText(value, size: 14, weight: bold ? FontWeight.w800 : FontWeight.w600),
        ],
      ),
    );
  }
}

class WriteReviewPage extends GetView<WriteReviewController> {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('write_a_review'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Obx(
            () => Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () => controller.rating.value = index + 1,
                  icon: Icon(
                    index < controller.rating.value ? Icons.star : Icons.star_border,
                  ),
                ),
              ),
            ),
          ),
          AppField(
            controller: controller.body.controller,
            label: 'share_thoughts'.tr,
            hint: 'review_hint'.tr,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          Obx(
            () => AppButton(
              label: 'publish_review'.tr,
              error: controller.error.value,
              onPressed: controller.submit,
            ),
          ),
        ],
      ),
    );
  }
}
