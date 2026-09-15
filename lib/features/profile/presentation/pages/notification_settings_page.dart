import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/profile/presentation/controllers/notification_settings_controller.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

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
