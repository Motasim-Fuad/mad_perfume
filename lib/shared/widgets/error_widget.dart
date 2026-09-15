import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/shared/widgets/custom_button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.danger),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              AppButton(label: 'retry'.tr, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
