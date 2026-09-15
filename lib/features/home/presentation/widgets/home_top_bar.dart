import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/features/home/presentation/controllers/home_controller.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final user = Get.find<SessionStore>().user;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'app_name'.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: controller.openLanguage,
            icon: const Icon(Icons.public_outlined, color: AppColors.ink),
          ),
          IconButton(
            onPressed: controller.openNotifications,
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.ink),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipOval(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: RemoteImage(
                    url: user.value?.avatarUrl ??
                        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80',
                    label: 'profile image here',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
