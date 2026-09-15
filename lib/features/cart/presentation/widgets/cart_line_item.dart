import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/cart/data/models/cart_item.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class CartLineItem extends StatelessWidget {
  const CartLineItem({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionStore>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 72,
            height: 72,
            child: RemoteImage(url: item.imageUrl),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.volume.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontSize: 10, letterSpacing: 1, color: AppColors.muted),
              ),
              Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => session.setQty(item.productId, item.quantity - 1),
                    icon: const Icon(Icons.remove, size: 16),
                  ),
                  Text('${item.quantity}'),
                  IconButton(
                    onPressed: () => session.setQty(item.productId, item.quantity + 1),
                    icon: const Icon(Icons.add, size: 16),
                  ),
                  const Spacer(),
                  MoneyText(item.lineTotal, size: 14),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
