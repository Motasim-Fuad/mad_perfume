import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/auth/presentation/widgets/auth_footer_link.dart';
import 'package:madperfume/features/auth/presentation/widgets/social_auth_row.dart';
import 'package:madperfume/shared/widgets/app_field.dart';
import 'package:madperfume/shared/widgets/brand_chrome.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthCubit>();
    return ScreenScaffold(
      header: const BrandHeader(showBack: true),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'create_your_account'.tr,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'join_world'.tr,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppColors.muted,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppField(
                    controller: controller.fullName,
                    label: 'full_name'.tr,
                    hint: 'Christian Dior',
                  ),
                  const SizedBox(height: 14),
                  AppField(
                    controller: controller.email,
                    label: 'email_address'.tr,
                    hint: 'name@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  AppField(
                    controller: controller.phone,
                    label: 'phone_number'.tr,
                    hint: '+1 (555) 000-0000',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 14),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (before, after) =>
                        before.obscureRegister != after.obscureRegister,
                    builder: (context, state) => AppField(
                      controller: controller.password,
                      label: 'password'.tr,
                      hint: '********',
                      obscure: state.obscureRegister,
                      onToggleObscure: controller.toggleRegisterObscure,
                    ),
                  ),
                  const SizedBox(height: 14),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (before, after) =>
                        before.obscureConfirm != after.obscureConfirm,
                    builder: (context, state) => AppField(
                      controller: controller.confirm,
                      label: 'confirm'.tr,
                      hint: '********',
                      obscure: state.obscureConfirm,
                      onToggleObscure: controller.toggleConfirmObscure,
                    ),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) => AppButton(
                      label: 'create_account'.tr,
                      loading: state.loading,
                      error: state.error,
                      onPressed: controller.register,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.line)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or_sign_up_with'.tr,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            letterSpacing: 1.2,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.line)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SocialAuthRow(
                    onGoogle: controller.socialUnavailable,
                    onApple: controller.socialUnavailable,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: AuthFooterLink(
                      prompt: 'have_account'.tr,
                      action: 'login'.tr,
                      onTap: () {
                        controller.clearError();
                        if (Navigator.of(context).canPop()) {
                          Get.back();
                        } else {
                          Get.toNamed(AppRoutes.login);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
