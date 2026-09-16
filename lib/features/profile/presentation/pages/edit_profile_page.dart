import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/remote_image.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<EditProfileCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text(
            'edit_profile'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<
            EditProfileCubit,
            ({bool loading, String error, Uint8List? avatarBytes})
          >(
            builder: (context, state) {
              final avatarUrl =
                  context.watch<AuthCubit>().state.profile?.avatarUrl ?? '';
              return Center(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: SizedBox.square(
                            dimension: 104,
                            child: state.avatarBytes != null
                                ? Image.memory(
                                    state.avatarBytes!,
                                    fit: BoxFit.cover,
                                  )
                                : avatarUrl.isNotEmpty
                                ? RemoteImage(url: avatarUrl)
                                : const ColoredBox(
                                    color: AppColors.surfaceMuted,
                                    child: Icon(
                                      Icons.person_outline,
                                      size: 42,
                                      color: AppColors.muted,
                                    ),
                                  ),
                          ),
                        ),
                        PositionedDirectional(
                          end: -4,
                          bottom: -4,
                          child: Material(
                            color: AppColors.ink,
                            shape: const CircleBorder(),
                            child: IconButton(
                              onPressed: state.loading
                                  ? null
                                  : controller.pickAvatar,
                              icon: const Icon(
                                Icons.photo_camera_outlined,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: state.loading ? null : controller.pickAvatar,
                      child: Text('change_profile_photo'.tr),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          AppField(controller: controller.name, label: 'full_name'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.email, label: 'email_address'.tr),
          const SizedBox(height: 12),
          AppField(controller: controller.phone, label: 'phone_number'.tr),
          const SizedBox(height: 12),
          AppField(
            controller: controller.address,
            label: 'address'.tr,
            maxLines: 3,
          ),
          const SizedBox(height: 22),
          BlocBuilder<
            EditProfileCubit,
            ({bool loading, String error, Uint8List? avatarBytes})
          >(
            builder: (context, state) => AppButton(
              label: 'save_changes'.tr,
              loading: state.loading,
              error: state.error,
              onPressed: controller.save,
            ),
          ),
        ],
      ),
    );
  }
}
