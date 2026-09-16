import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
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
          BlocBuilder<EditProfileCubit, ({String error, bool loading})>(
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
