import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/glossy_card.dart';
import 'package:madperfume/shared/widgets/money_text.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class SavedItemsPage extends GetView<ProfileController> {
  const SavedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Obx(() {
        final items = controller.saved;
        if (items.isEmpty) {
          return EmptyWidget(message: 'empty_saved'.tr);
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final product = items[index];
            return GlossyCard(
              onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product.id),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(width: 64, height: 64, child: RemoteImage(url: product.imageUrl)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                        MoneyText(product.price, size: 13),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
