import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/shared/widgets/empty_widget.dart';
import 'package:madperfume/shared/widgets/shimmer_loading_list.dart';

class QueryBody extends StatelessWidget {
  const QueryBody({
    super.key,
    required this.loading,
    required this.error,
    required this.child,
    this.empty = false,
    this.emptyMessage,
    this.onRetry,
    this.onRefresh,
  });

  final bool loading;
  final String error;
  final bool empty;
  final String? emptyMessage;
  final VoidCallback? onRetry;
  final Future<void> Function()? onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget body;
    var staticBody = false;
    if (loading) {
      body = const ShimmerLoadingList();
    } else if (error.isNotEmpty) {
      staticBody = true;
      body = Center(
        key: const ValueKey('query-error'),
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
    } else if (empty) {
      staticBody = true;
      body = EmptyWidget(
        key: const ValueKey('query-empty'),
        message: emptyMessage ?? 'no_results'.tr,
      );
    } else {
      body = KeyedSubtree(key: const ValueKey('query-content'), child: child);
    }
    if (!loading && onRefresh != null) {
      final currentBody = body;
      body = staticBody
          ? LayoutBuilder(
              builder: (context, constraints) => RefreshIndicator.adaptive(
                onRefresh: onRefresh!,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: currentBody,
                  ),
                ),
              ),
            )
          : RefreshIndicator.adaptive(
              onRefresh: onRefresh!,
              child: ScrollConfiguration(
                behavior: const _AlwaysScrollableBehavior(),
                child: currentBody,
              ),
            );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 360),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      child: body,
    );
  }
}

class _AlwaysScrollableBehavior extends MaterialScrollBehavior {
  const _AlwaysScrollableBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return AlwaysScrollableScrollPhysics(parent: super.getScrollPhysics(context));
  }
}
