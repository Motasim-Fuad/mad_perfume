import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/features/profile/presentation/widgets/order_history_card.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final orders = state.items;
          if (orders.isEmpty) {
            return EmptyWidget(message: 'empty_orders'.tr);
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            itemCount: orders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderHistoryCard(
                order: order,
                onTap: () => Get.toNamed('/order-details', arguments: order.id),
              );
            },
          );
        },
      ),
    );
  }
}
