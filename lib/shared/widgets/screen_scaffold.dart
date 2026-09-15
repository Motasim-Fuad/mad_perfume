import 'package:flutter/material.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.child,
    this.header,
    this.bottom,
    this.padding,
  });

  final Widget child;
  final Widget? header;
  final Widget? bottom;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ?header,
            Expanded(
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
                child: child,
              ),
            ),
            ?bottom,
          ],
        ),
      ),
    );
  }
}
