import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PrefsCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => ListView(
          children: [
            Text(
              'notifications'.tr,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'preference_center'.tr,
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
            ),
            Text(
              'preference_copy'.tr,
              style: GoogleFonts.dmSans(color: AppColors.muted),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('promotional_offers'.tr),
              value: state.profile?.notifyCollections ?? false,
              onChanged: (value) => controller.setNotify(collections: value),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('exclusive_releases'.tr),
              value: state.profile?.notifyRewards ?? false,
              onChanged: (value) => controller.setNotify(rewards: value),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text('member_status_update'.tr),
              value: state.profile?.notifyOrders ?? false,
              onChanged: (value) => controller.setNotify(orders: value),
            ),
          ],
        ),
      ),
    );
  }
}
