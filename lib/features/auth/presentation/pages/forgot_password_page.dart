import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'forgot_title'.tr,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 34,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'forgot_body'.tr,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.muted,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 24),
            AppField(
              controller: controller.resetEmail,
              label: 'email_address'.tr,
              hint: 'name@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 28),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => AppButton(
                label: 'send_code'.tr,
                loading: state.loading,
                error: state.error,
                onPressed: controller.sendCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
