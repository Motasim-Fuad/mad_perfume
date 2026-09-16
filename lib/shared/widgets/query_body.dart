import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/loading_widget.dart';

class QueryBody extends StatelessWidget {
  const QueryBody({
    super.key,
    required this.loading,
    required this.error,
    required this.child,
    this.empty = false,
    this.emptyMessage,
    this.onRetry,
  });

  final bool loading;
  final String error;
  final bool empty;
  final String? emptyMessage;
  final VoidCallback? onRetry;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LoadingWidget();
    }
    if (error.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(color: AppColors.muted, height: 1.4),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 12),
                TextButton(onPressed: onRetry, child: Text('retry'.tr)),
              ],
            ],
          ),
        ),
      );
    }
    if (empty) {
      return EmptyWidget(message: emptyMessage ?? 'no_results'.tr);
    }
    return child;
  }
}
