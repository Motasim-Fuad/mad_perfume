import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/profile/presentation/controllers/profile_controller.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('settings'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          _tile('edit_profile'.tr, controller.editProfile),
          _tile('security'.tr, controller.security),
          _tile('notifications'.tr, controller.notifications),
          _tile('logout'.tr, controller.logout, danger: true),
        ],
      ),
    );
  }

  Widget _tile(String label, VoidCallback onTap, {bool danger = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: GoogleFonts.dmSans(color: danger ? AppColors.danger : AppColors.ink, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('edit_profile'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          AppField(controller: controller.name.controller, label: 'full_name'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.email.controller, label: 'email_address'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.phone.controller, label: 'phone_number'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.address.controller, label: 'address'.tr, maxLines: 3),
          const SizedBox(height: 22),
          Obx(
            () => AppButton(
              label: 'save_changes'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.save,
            ),
          ),
        ],
      ),
    );
  }
}

class SecurityPage extends GetView<SecurityController> {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text('update_password'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          AppField(controller: controller.current.controller, label: 'current_password'.tr, obscure: true),
          const SizedBox(height: 12),
          AppField(controller: controller.next.controller, label: 'new_password'.tr, obscure: true),
          const SizedBox(height: 12),
          AppField(controller: controller.confirm.controller, label: 'confirm_password'.tr, obscure: true),
          const SizedBox(height: 22),
          Obx(
            () => AppButton(
              label: 'update_password_btn'.tr,
              loading: controller.loading.value,
              error: controller.error.value,
              onPressed: controller.updatePassword,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationSettingsPage extends GetView<NotificationSettingsController> {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = controller.session;
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: Obx(
        () => ListView(
          children: [
            Text('notifications'.tr, style: GoogleFonts.cormorantGaramond(fontSize: 30, fontWeight: FontWeight.w600)),
            Text('preference_center'.tr, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)),
            Text('preference_copy'.tr, style: GoogleFonts.dmSans(color: AppColors.muted)),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('promotional_offers'.tr),
              value: session.promoOffers.value,
              onChanged: (value) {
                session.promoOffers.value = value;
                controller.persist();
              },
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('exclusive_releases'.tr),
              value: session.exclusiveReleases.value,
              onChanged: (value) {
                session.exclusiveReleases.value = value;
                controller.persist();
              },
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('member_status_update'.tr),
              value: session.memberUpdates.value,
              onChanged: (value) {
                session.memberUpdates.value = value;
                controller.persist();
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
