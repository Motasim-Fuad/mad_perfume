import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/branches/presentation/controllers/branches_controller.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class BranchesPage extends GetView<BranchesController> {
  const BranchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text('branches'.tr, style: GoogleFonts.dmSans(letterSpacing: 2, fontSize: 12, color: AppColors.muted)),
                Text('physical_ateliers'.tr, textAlign: TextAlign.center, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
                Text('branches_intro'.tr, textAlign: TextAlign.center, style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4, fontSize: 13)),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => controller.query.value = value,
                  decoration: InputDecoration(
                    hintText: 'search_city'.tr,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surfaceMuted,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final items = controller.items;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final branch = items[index];
                  return GestureDetector(
                    onTap: () => controller.open(branch.id),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.7,
                            child: RemoteImage(url: branch.imageUrl, label: 'boutique image here'),
                          ),
                          Container(
                            width: double.infinity,
                            color: AppColors.surface,
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(branch.name, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
                                Text(branch.address, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(color: AppColors.muted, fontSize: 12)),
                                Text(branch.openUntil, style: GoogleFonts.dmSans(fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class BranchDetailsPage extends GetView<BranchDetailsController> {
  const BranchDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final branch = controller.branch;
    return ScreenScaffold(
      padding: EdgeInsets.zero,
      header: const BrandHeader(showBack: true),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text('branch_details'.tr, style: GoogleFonts.dmSans(letterSpacing: 2, fontSize: 11, color: AppColors.muted)),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: RemoteImage(url: branch.imageUrl, label: 'boutique image here'),
            ),
          ),
          const SizedBox(height: 16),
          Text('flagship_boutique'.tr, style: GoogleFonts.dmSans(letterSpacing: 1.6, fontSize: 11, color: AppColors.muted)),
          Text(branch.name.toUpperCase(), style: GoogleFonts.cormorantGaramond(fontSize: 28, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _block('address'.tr, branch.address),
          _block('contact'.tr, '${branch.phone}\n${branch.email}'),
          _block('hours'.tr, branch.hours),
        ],
      ),
    );
  }

  Widget _block(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
          Text(body, style: GoogleFonts.dmSans(height: 1.45, color: AppColors.inkSoft)),
        ],
      ),
    );
  }
}
