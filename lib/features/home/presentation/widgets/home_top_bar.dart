import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/home/presentation/cubit/home_cubit.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeCubit>();
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
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.ink,
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipOval(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: RemoteImage(
                    url:
                        state.profile?.avatarUrl ??
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
