import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_header.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';
import 'package:madperfume/shared/widgets/screen_scaffold.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SecurityCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: ListView(
        children: [
          Text(
            'update_password'.tr,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          AppField(
            controller: controller.current,
            label: 'current_password'.tr,
            obscure: true,
          ),
          const SizedBox(height: 12),
          AppField(
            controller: controller.next,
            label: 'new_password'.tr,
            obscure: true,
          ),
          const SizedBox(height: 12),
          AppField(
            controller: controller.confirm,
            label: 'confirm_password'.tr,
            obscure: true,
          ),
          const SizedBox(height: 22),
          BlocBuilder<SecurityCubit, ({String error, bool loading})>(
            builder: (context, state) => AppButton(
              label: 'update_password_btn'.tr,
              loading: state.loading,
              error: state.error,
              onPressed: controller.updatePassword,
            ),
          ),
        ],
      ),
    );
  }
}
