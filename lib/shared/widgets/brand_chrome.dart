import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madperfume/core/constants/app_colors.dart';
import 'package:madperfume/core/services/locale_service.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.showBack = false,
    this.trailing,
    this.centerTitle = true,
  });

  final bool showBack;
  final Widget? trailing;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: Get.back,
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.ink,
              ),
            )
          else
            const SizedBox(width: 12),
          Expanded(
            child: Text(
              'app_name'.tr,
              textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 3.2,
              ),
            ),
          ),
          trailing ?? const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class GlossyCard extends StatelessWidget {
  const GlossyCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) {
      return card;
    }
    return GestureDetector(onTap: onTap, child: card);
  }
}

class MoneyText extends StatelessWidget {
  const MoneyText(this.value, {super.key, this.size = 16, this.weight = FontWeight.w700});

  final double value;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    final rtl = Get.find<LocaleService>().isRtl;
    final amount = value.toStringAsFixed(2);
    return Text(
      rtl ? '$amount \$' : '\$$amount',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.dmSans(fontSize: size, fontWeight: weight, color: AppColors.ink),
    );
  }
}

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
