import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/auth/presentation/widgets/auth_footer_link.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthCubit>();
    return ScreenScaffold(
      header: const BrandHeader(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    ClipOval(
                      child: Image.asset(
                        'assets/icon/app_icon.png',
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'welcome_back'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'sign_in_subtitle'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: AppColors.muted,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppField(
                      controller: controller.loginId,
                      label: 'email_or_phone'.tr,
                      hint: 'enter_your_details'.tr,
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (before, after) =>
                          before.obscureLogin != after.obscureLogin,
                      builder: (context, state) => AppField(
                        controller: controller.loginPassword,
                        label: 'password'.tr,
                        hint: '********',
                        obscure: state.obscureLogin,
                        onToggleObscure: controller.toggleLoginObscure,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          controller.clearError();
                          Get.toNamed(AppRoutes.forgotPassword);
                        },
                        child: Text(
                          'forgot_password'.tr,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.muted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) => AppButton(
                        label: 'login'.tr,
                        loading: state.loading,
                        error: state.error,
                        onPressed: controller.login,
                      ),
                    ),
                    const SizedBox(height: 18),
                    AuthFooterLink(
                      prompt: 'no_account'.tr,
                      action: 'create_account'.tr,
                      onTap: () {
                        controller.clearError();
                        Get.toNamed(AppRoutes.register);
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '© 2026 MAD perfume. Invisible elegance.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
